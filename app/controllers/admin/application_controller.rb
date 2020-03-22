# ApplicationControllerを継承しているがいいのか？
class Admin::ApplicationController < ApplicationController
  before_action :logged_in_admin

  private
  def logged_in_admin
    return render json: 'ログインしてください', status: 401 unless logged_in?
    unless current_user.admin?
      render json: '権限がありません', status: 400
    end
  end
end
