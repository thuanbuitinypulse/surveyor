class SessionsController < ApplicationController
  def new
    build_sign_in
  end

  def create
    build_sign_in
    if @sign_in.valid?
      session[:user_id] = @sign_in.user_id
      redirect_to users_path, notice: "Logged in!"
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, alert: "Logged out."
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password) if params[:sign_in]
  end

  def build_sign_in
    @sign_in = SignIn.new sign_in_params
  end
end
