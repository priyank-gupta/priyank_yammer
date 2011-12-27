class CommentsController < ApplicationController

  def create
    commentable = Feed.find(params[:feed_id])
    p commentable
    unless params[:comment] === "" || params[:comment] === nil
      commentable.comments.create(:comment => params[:comment], :user_id => current_user.id)
    end
    redirect_to feeds_path
  end
end
