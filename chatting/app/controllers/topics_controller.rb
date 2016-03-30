class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
      @q = Topic.ransack(params[:q])
      @topics = @q.result(distinct: true)

      if params[:sort] == "id"
        @topics = @topics.order("id")
      elsif params[:sort] == "updated"
        @topics = @topics.order("updated_at DESC")
      else
        @topics = @topics.order("id DESC")
      end

      @topics = @topics.page( params[:page] )
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
