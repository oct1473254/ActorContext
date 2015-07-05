class Actor 
	# validates :first_name, presence: true
	# validates :last_name, presence: true

	def nyplsearch
		url = "http://api.repo.nypl.org/api/v1/items/search.json?q=#{@first_name}+#{@last_name}&field=title"
	# lines 22 -32 make no sense to me
		uri = URI.escape(url)
		puts uri
		uri = URI.parse(uri)
		http = Net::HTTP.new(uri.host, uri.port)

		mykey = ENV['NYPL_KEY']	
		headers = { "Authorization" => "Token token=#{mykey}" }
		request = Net::HTTP::Get.new(uri.request_uri, headers)
		response = http.request(request)
		@response = JSON.parse(response.body)
	end 

	def nyplresults
		@nyplresults = @response["nyplAPI"]["response"]["result"].map do |data| 
			{title: data["title"], itemlink: data["itemLink"]} 
		end
	end

	def wikipedia_search
		page = Wikipedia.find( "#{@first_name}+#{@last_name}" ).content
		@found = page
	end

	def wikipedia_results
		@wikipediaresults = @found.map do |data| 
			{title: data["title"], itemlink: data["itemLink"]} 
		end
	end

	def imdb_search
		uri = URI("http://www.myapifilms.com/imdb?name=#{@first_name}+#{@last_name}&format=JSON&filmography=1&limit=1&lang=en-us&exactFilter=0&bornDied=1&starSign=1&uniqueName=1&actorActress=1&actorTrivia=1&actorPhotos=N&actorVideos=N&salary=0&spouses=1&tradeMark=0&personalQuotes=1&token=010bafc9-ce69-49b2-a6ef-80e2224e8553")
		@response = Net::HTTP.get_response(uri)
		puts "retrieved from: #{uri}"
		puts @response.body
	end 

	def imdb_results
		@imdb_results = @response["actorActress"].map do |data| 
			{name: data["birthName"], bio: data["bio"], filmography: data["filmography"], height: data["height"], weblink: data["idIMDB"], personalQuotes: data["personalQuotes"], starSign: data["starSign"], trivia: data["trivia"]} 
		end
	end
end
