# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    User.find(1)  # 今はあきらさんをログイン中と仮定
  end
end