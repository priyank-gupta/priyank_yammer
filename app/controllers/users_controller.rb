class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    p params
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Confirmation mail has been sent to "+params[:user][:email]
    else
      render new_user_path
    end
  end
  
end
