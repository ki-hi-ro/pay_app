# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end  
end 