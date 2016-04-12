class Tag < ActiveRecord::Base

  has_many :topic_taggers
  has_many :topics, :through => :topic_taggers

end
