class NyplActor
	

	attr_reader :title, :itemlink, :imageID

	def initialize(options = {})
		@title = options[:title]
		@itemlink = options[:itemlink]
		@imageID = options[:imageID]
	end

	def image_url
		"http://images.nypl.org/index.php?id=#{@imageID}&t=w"
	end

	def itemlink
		@itemlink 
	end

end