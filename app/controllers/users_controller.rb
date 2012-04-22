class UsersController < ApplicationController
  def show
  	#@user = User.find(params[:id])	 #change this to User.find(params[:id])
  	@user = current_user
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
end
