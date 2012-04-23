class UsersController < ApplicationController
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def show  
    if params[:id]
      @user = User.find(params[:id])      
    else
      @user = current_user
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in(@user, :bypass => true)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.search(params[:search])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end

  private
    def correct_user
      redirect_to(root_path) unless current_user == User.find(params[:id])
    end

end
