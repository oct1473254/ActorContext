class HomeController < ApplicationController
  def index
 
  end




def make
    # Assignment
    pdf = Prawn::Document.new
    pdf.text params[:text]
    name = rand(1000..100000)
    pdf.render_file "./public/#{name}.pdf"
    redirect_to "/#{name}.pdf"
    end
end

