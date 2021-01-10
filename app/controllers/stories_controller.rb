class StoriesController < ApplicationController
  before_action :authenticate_user!
  def  new
    @story=current_user.stories.new
  end

  def create
    @story=current_user.stories.new(story_permit)
    if @story.save
     redirect_to stories_path,notice: '新增成功'
    else
      render :new
    end  
    
  end

  private
  def story_permit
    params.require(:story).permit(:title,:content)
  end
end
