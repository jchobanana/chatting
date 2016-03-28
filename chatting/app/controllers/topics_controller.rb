class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.page(params[:page]).per(10)
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( topic_params )
    @topic.user = current_user
    if @topic.save
      redirect_to topic_url(@topic)
    end
  end

  def display_name
    email.split('@').first
  end

  protected

  def topic_params
    params.require(:topic).permit(:content, :subject, :image)
  end

end
