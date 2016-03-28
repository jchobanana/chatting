class TopicsController < ApplicationController
  def index
    @topics = Topic.page(params[:page]).per(10)
  end

  def show
    @topic = Topic.find(params[:id])
  end
end
