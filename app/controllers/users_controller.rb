class UsersController < ApplicationController
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
    @search = User.search do
      fulltext params[:search]
    end
    @users = @search.results
  end
end
