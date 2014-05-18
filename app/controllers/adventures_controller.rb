class AdventuresController < ApplicationController
  def index 
    @library = Library.new 
    @adventure = Adventure.all 
    respond_to do |format| 
      format.html 
      format.json {render :json => {:adventures => @adventures.as_json
        (except: [:id, :library_id], include: {:pages =>
          {except: [:id, :adventure_id, :created_at, :updated_at]} })} }
    end
  end

  def new 
    @adventure = Adventure.new
  end

  def create 
    @adventure = Adventure.create(adventure_params)
    @adventure.save 
    @adventure.update_attributes(:guid => SecureRandom.urlsafe_base64(10))
    redirect_to adventures_path
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update 
    @adventure = Adventure.find(params[:id])
    @adventure.update(adventure_params)
    redirect_to adventures_path
  end

  def destroy
    adventure = Adventure.find(params[:id])
    adventure.delete 
    redirect_to(adventures_path)
  end

  private 
    def load_adventure
      @adventure = Adventure.find(params[:id])
    def adventure_params 
      params.require(:adventure.permit(:title, :author, :pages_attributes => [:name, :text]))
    end


end
