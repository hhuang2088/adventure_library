class PagesController < ApplicationController
  before_action :load_adventure

  def index
    @pages = @adventure.pages.all 
  end

  def show
    @page = @adventure.pages.new
  end

  def create 
    @page = @adventure.pages.create(page_params)
    @page[:user_id] = current_user.id
    if @page.save 
      redirect_to adventure_pages_path(@adventure)
    end
  end

  private 

  def load_adventure 
    @adventure = Adventure.find(params[:adventure_id])
  end

  def page_params
    params.require(:page).permit(:name, :text)
  end
  
end
