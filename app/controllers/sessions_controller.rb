# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    @users = User.all
  end

  def create
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    redirect_to debts_path, notice: "#{user.name} としてログインしました"
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "ログアウトしました"
  end
end