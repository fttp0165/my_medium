class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story,only:[:edit,:update,:destroy]
  def  index
    @stories=current_user.stories.order(created_at: :desc)
  end
  def  new
    @story=current_user.stories.new
  end
 
  def edit
    
  end

  def update
    if @story.update(story_permit)
      redirect_to stories_path,notice: '故事更新成功'
    else
      render :edit
    end
  end
  def create
    @story=current_user.stories.new(story_permit)
    if @story.save
     if params[:publish]
      redirect_to stories_path,notice: '已成功發布故事'
     else
      redirect_to eedit_story_path(@story),notice: '故事儲存'
     end 
    else
      render :new
    end  
  end

  def destroy
    @story.destroy
    redirect_to stories_path,notice: '故事已刪除成功'
  end

  private
  def find_story
    @story=current_user.stories.find(params[:id])
  end
  def story_permit
    params.require(:story).permit(:title,:content)
  end
end
