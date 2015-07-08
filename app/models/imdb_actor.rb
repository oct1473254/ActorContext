class ImdbActor
	

	attr_reader :bio, :birthname, :born, :dateofbirth, :name, :height, :filmography, :imdbID

	def initialize(options = {})
		@bio = options[:bio]
		@name = options[:name]
		@born = options[:dateofbirth]
		@height = options[:height]
		@filmography = options[:filmography]
		
	end

	def filmography 
	end

	def imdbID
		"http://www.imdb.com/title/#{imdbID}/?ref_=nv_sr_3"
	end
end