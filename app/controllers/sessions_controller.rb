# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_or_create_by(name: params[:name])
    session[:user_id] = user.id
    redirect_to payments_path, notice: "ログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "ログアウトしました"
  end
end