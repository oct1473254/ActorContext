class ActorsController < ApplicationController
	def new
	end

	def index
		@actors = Actor.all
	end

	def edit
		@actor = Actor.find(params[:id])
	end

	def search
		Actor.wikipedia_search(params[:first_name, :last_name])
	end


	def create
		  @actor = Actor.new(actor_params)
  			if @actor.save
 			 redirect_to @actor
 			else
 				render 'new'
 			end
	end

	def show
		@actor = Actor.find(params[:id])
	end

	def update
 	 @actor = Actor.find(params[:id])
 
 	 if @actor.update(actor_params)
   	 redirect_to @actor
 	 else
  	  render 'edit'
 	 end
	end


	private
	def actor_params
		params.require(:actor).permit(:first_name, :last_name)
	end
end
