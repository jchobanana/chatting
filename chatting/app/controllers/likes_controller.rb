class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    like = @topic.finy_like_by(current_user)

    if like

    else
     @like =  @topic.likes.create!( :user => current_user)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "like" }
    end
  end

  def destroy
    @like = current_user.likes.find( params[:id] )
    @like.destroy

    @like = nil

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render "like" }
    end
  end

  protected

  def set_topic
    @topic = Topic.find( params[:topic_id] )
  end

end
