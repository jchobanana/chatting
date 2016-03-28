class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    @topics = Topic.page(params[:page]).per(10)
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def display_name
    email.split('@').first
  end
end
