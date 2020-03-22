class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: [:show]

  def show
    res = {logged_in: logged_in?}
    if logged_in?
      res[:alert_warnings] = [current_user.diaries_warning]
    end
    render json: res
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
