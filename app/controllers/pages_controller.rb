class PagesController < ApplicationController  
  def index
  	@stories=Story.order(created_at: :desc).includes(:user).where(status: :published)
  end

  def new
    
  end

  def  show
    
  end

  def user
    
  end

  
end
