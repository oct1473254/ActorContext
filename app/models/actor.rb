class Actor < ActiveRecord::Base
   has_many :searches
   has_many :users, :through => :searches  
	
	require 'wikipedia'
	# validates :first_name, presence: true
	# validates :last_name, presence: true

	def nyplsearch
		url = "http://api.repo.nypl.org/api/v1/items/search.json?q=#{self.first_name}+#{self.last_name}&field=title"
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
			NyplActor.new(title: data["title"], itemlink: data["itemLink"], imageID: data["imageID"])
		end
	end

	def nyplimage
		@image_id = @response["nyplAPI"]["response"]["result"].map do |data|
			{imageid: data["imageId"]}
		end
	end

	def wikipedia_search
	
		page = Wikipedia.find( "#{self.first_name}+#{self.last_name}" )
		clean = page.sanitized_content.html_safe
		@found = clean

	end

	def wikipedia_results
		@wikipediaresults = @found
	end

	def imdb_search
		@mykey = ENV['IMDB_KEY']
		uri = URI("http://www.myapifilms.com/imdb?name=#{self.first_name}+#{self.last_name}&format=JSON&filmography=1&limit=1&lang=en-us&exactFilter=0&bornDied=1&starSign=1&uniqueName=0&actorActress=1&actorTrivia=1&actorPhotos=N&actorVideos=N&salary=1&spouses=1&tradeMark=1&personalQuotes=1&token=#{@mykey}")
		@response = Net::HTTP.get_response(uri)
		@response = JSON.parse(@response.body)	
	end 

	def imdb_results
		@imdb_results = @response
		 @response.map do |data| 
		 	ImdbActor.new(name: data["birthName"], bio: data["bio"], filmography: data["filmography"], height: data["height"], weblink: data["idIMDB"], personalQuotes: data["personalQuotes"], starSign: data["starSign"], trivia: data["trivia"]) 
		 end
	end

	def viaf_search
		uri = URI("http://www.viaf.org/viaf/search?query=cql.any+=+#{self.first_name}+#{self.last_name}&maximumRecords=5&httpAccept=application/json")
		response = Net::HTTP.get_response(uri)
		@response = JSON.parse(response.body)
	end

	def viaf_results
		@viaf_results = @response
	end

end
