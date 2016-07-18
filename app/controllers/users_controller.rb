class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    build_user
  end

  def create
    build_user
    if @user.save
      redirect_to users_path, notice: "User created."
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password) if params[:user]
  end
  def build_user
    @user = User.new user_params
  end
end
