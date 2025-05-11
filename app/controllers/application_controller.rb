# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find(2)  # ← ここを「さゆり」（id:2）に変更
  end
end 