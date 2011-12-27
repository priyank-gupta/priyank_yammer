class FeedsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    if current_user.user_type == "normal"
      follow_ids = Feed.find_feeds_of_user_and_following_users(current_user)
      @feeds = Feed.where("user_id in (?)", follow_ids)
    elsif current_user.user_type == "admin"
      @feeds = Feed.all
    end
  end
  
  def create
    @feed = Feed.new(:content => params[:content], :user_id => current_user.id)
    @feed.save
    redirect_to feeds_path
  end
  
  def follow
    follow = Follow.new(:user_id => current_user.id, :follow => params[:follow_id])
    follow.save
    redirect_to feeds_path
  end
  
  def destroy
    p params
    @feed = Feed.where("id = ?", params[:id]).first
    if current_user.user_type == "admin"
      @feed.destroy
    end
    redirect_to(feeds_url) 
  end
end
