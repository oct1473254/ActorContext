class ImdbActor
	

	attr_reader :bio, :birthname, :born, :dateofbirth, :name, :height, :filmography, :imdbid, :title, :year, :personalQuotes, :trivia

	def initialize(options = {})
		@bio = options[:bio]
		@name = options[:name]
		@born = options[:dateofbirth]
		@height = options[:height]
		@filmography = options[:filmography]
		@imdbid = options[:imdbid]
		@personalquotes = options[:personalQuotes]
		@trivia = options[:trivia]
		
	end

	def filmography 
	end

	def imdb_link
		"http://www.imdb.com/title/#{imdbID}/?ref_=nv_sr_3"
	end
end