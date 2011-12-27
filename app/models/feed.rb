class Feed < ActiveRecord::Base

  acts_as_commentable
  
  belongs_to :user
#  has_attached_file :image_url, :styles => { :medium => "300x300>", :thumb => "100x100>" }
#  has_many :comments
  
  validates :content, :presence => true
  
  before_create :validate_blank_space
  
  def validate_blank_space
    if content =~ /^\s+$/
      return false
    else
      return true
    end
  end
  
  def self.find_feeds_of_user_and_following_users(current_user)
    follows = Follow.where("user_id = #{current_user.id}")
    follow_ids = []
    follows.each do |follow|
      follow_ids.push(follow.follow)
    end
    follow_ids.push(current_user.id)
  end
end
