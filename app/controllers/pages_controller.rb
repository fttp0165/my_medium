class PagesController < ApplicationController  
  before_action :find_story,only: [:show]

  def index
  	@stories=Story.published_stories.limit(4)
    @stories_clap=Story.published_stories.order(:clap).limit(5)
    @stories_sample=Story.published_stories.where("clap>5" ).sample(3)
    @story_sample=Story.published_stories.where("clap>20"|| "clap=0").sample
    if  @stories_sample.nil?
      @stories_sample=Story.published_stories.limit(5)
    end
    if  @story_sample.nil?
      @story_sample=Story.published_stories.sample
    end
  
    @story_current=Story.published_stories.order(:created_at).first
  end
  def new
    
  end

  def hot
    @stories=Story.published_stories.where("clap>20"|| "clap>=0")
  end

  def pop
    @authors=[]
    @follows=Follow.group(:following_id).count.sort_by{|_key, value| value}.reverse
    @follows.each do |user_id|
      @authors.push(User.find(user_id[0]))
    end
    @authors

  end

  def  show
    @comment=@story.comments.new
    @comments=@story.comments.order(id: :desc)
  end

  def user
    @author=User.find_by(username: params[:username])
  end


  def find_story
    @story=Story.friendly.find(params[:story_id])
  end

  
end
