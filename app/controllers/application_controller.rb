class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user
    return @current_user if @current_user
    if session[:user_id]
      @current_user = User.find_by_id session[:user_id]
    end
  end
end
