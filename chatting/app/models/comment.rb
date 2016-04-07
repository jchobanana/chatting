class Comment < ActiveRecord::Base

  validates_presence_of :content
  belongs_to :topic, :counter_cache => true


  belongs_to :user
end
