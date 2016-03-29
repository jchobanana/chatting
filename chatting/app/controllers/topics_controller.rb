class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.order('id DESC').page(params[:page]).per(10)
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new( topic_params )
    @topic.user = current_user
    if @topic.save
      redirect_to topic_url(@topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end



  protected

  def topic_params
    params.require(:topic).permit(:content, :subject)
  end
  def set_my_topic
    @topic = current_user.topics.find( params[:id])
  end
end
