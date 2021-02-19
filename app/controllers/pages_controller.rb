class PagesController < ApplicationController  
  before_action :find_story,only: [:show]

  def index
  	@stories=Story.published_stories.limit(4)
    @stories_clap=Story.published_stories.order(:clap).limit(5)
    @stories_sample=Story.published_stories.where("clap>5" ).sample(3)
    if  @stories_clap.nil?
      @stories_clap=Story.published_stories.limit(5)
    end
    if  @stories_sample.nil?
      @stories_sample=Story.published_stories.sample(3)
    end
    @story_sample=Story.published_stories.where("clap>20"|| "clap=0").sample
    @story_current=Story.published_stories.order(:created_at).first
  end
  def new
    
  end

  def  show
    @comment=@story.comments.new
    @comments=@story.comments.order(id: :desc)
  end

  def user
    
  end


  def find_story
    @story=Story.friendly.find(params[:story_id])
  end

  
end
