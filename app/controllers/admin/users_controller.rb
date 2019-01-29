class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      redirect_to admin_users_url, notice: "Sucessfully created '#{@user}'"
    else
      render 'new'
    end
  end 

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      if current_user.role == "admin"
        redirect_to admin_users_url, notice: "Sucessfully updated '#{@user}'"
      else
        redirect_to root_url, notice: "Sucessfully updated user account"
      end
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_url, notice: "Sucessfully deleted '#{@user}'"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :platform_ids => [])
  end
end
