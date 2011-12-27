class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => "Confirmation mail has been sent to "+params[:user][:email]
    else
      render new_user_path
    end
  end
  
  def index
    @users = User.all - User.where("id = (?)", current_user.id)
  end
  
  def destroy
    @user = User.where("id = ?", params[:id]).first
    if current_user.user_type == "admin"
      @user.delete
    end
    redirect_to users_url
  end
  
  def my_profile
    @user = current_user
  end
  
  def edit_my_profile
    @user = current_user
  end
  
  def update_my_profile
    p "_____________________"
    p params
    @user = current_user
    @user.update_attributes(params[:put])
    redirect_to my_profile_users_path
  end
  
  def update
    p params
    redirect_to my_profile_users_path
  end
  
  def edit
    @user = current_user
  end
end
