class UsersController < ApplicationController
  before_action :grant_access!

  def index
    @users = User.where.not(:id => current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User details updated successfully."
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted successfully."
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :admin)
  end

  def grant_access!
    if current_user.try(:admin?)
      return true
    else
      flash[:notice] = "Access denied."
      redirect_to root_path
    end
  end
end
