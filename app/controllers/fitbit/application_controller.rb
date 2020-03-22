class Fitbit::ApplicationController < ApplicationController
  before_action :associate_fitbit_account

  private

  def associate_fitbit_account
    if fitbit_account.blank?
      render json: 'Settingsから連携してください。', status: 400
    end
  end

  def fitbit_account
    @fitbit_account ||= current_user.fitbit_account
  end
end
