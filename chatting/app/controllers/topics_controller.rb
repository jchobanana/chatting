class TopicsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_my_topic, :only => [:edit, :update, :destroy]

  def index

      @q = Topic.ransack(params[:q])

      @topics = @q.result(distinct: true)

      if params[:sort] == "by ID"
         @topics = @topics.order("id")
      elsif params[:sort] == "by time"
        @topics = @topics.order("updated_at DESC")
      elsif params[:sort] == "by replies"
        @topics = @topics.order("comments_count")
      elsif params[:sort] == "by categories"
        @topics = Category.find(params[:category_id]).topics
      else
        @topics = @topics.order("id DESC")
      end

      @topics = @topics.where( :status => "published" )
      @topics = @topics.page(params[:page]).per(10)

        respond_to do |format|
          format.html
          format.js
        end

    end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @users = User.where(:id =>@topic.likes.pluck(:user_id))


    unless cookies["view-topic=#{@topic.id}"]
      cookies["view-topic-#{@topic.id}"] = "viewed"
      @topic.views_count += 1
      @topic.save!
    end

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
    @topic.destroy
    redirect_to topics_url
  end

  def update
    if params[:destory_image]
      @topic.image = nil
    end

    if @topic.update( topic_params )
      redirect_to topic_url(@topic)
    else
      render "edit"
    end
  end

  def subscribe
    @topic = Topic.find( params[:id] )
    @topic.subscriptions.create!( :user => current_user)
    # subscription = @topic.finy_subscription_by(current_user)
    # if subscription
    # else
      # @subscription = @topic.subscriptions.create!( :user => current_user)
    respond_to do |format|
      format.html{ redirect_to :back }
      format.js
    end
  end
    # redirect_to :back
  # end

  def unsubscribe
    @topic = Topic.find( params[:id] )
    current_user.subscriptions.where( :topic_id => @topic.id ).destroy_all

    # subscription = @topic.finy_subscription_by(current_user)
    # subscription.destroy

    # redirect_to :back
    respond_to do |format|
      format.html{ redirect_to :back }
      format.js { render "subscribe"}
    end
  end



  protected

  def topic_params
    params.require(:topic).permit(:content, :subject, :image, :category_id, :status, :tag_ids => [])
  end

  def set_my_topic
    @topic = Topic.find( params[:id])
  end

end
