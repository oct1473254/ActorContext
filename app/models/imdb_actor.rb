class ImdbActor
	

	attr_reader :bio, :birthname, :born, :dateofbirth, :name, :height, :filmography, :imdbid, :title, :year, :starsign, :personalquotes, :trivia

	def initialize(options = {})
		@bio = options[:bio]
		@name = options[:name]
		@born = options[:dateofbirth]
		@height = options[:height]
		@filmography = options[:filmography]
		@imdbid = options[:imdbid]
		@personalquotes = options[:personalquotes]
		@trivia = options[:trivia]
		@year = options[:year]
		@title = options[:title]
		@starsign = options[:starsign]
	
		
	end

	def filmography 
	end

	def imdb_link
		"http://www.imdb.com/title/#{imdbid}/?ref_=nv_sr_3"
	end
end