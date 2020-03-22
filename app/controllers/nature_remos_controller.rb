class NatureRemosController < ApplicationController
  def create
    access_token = params[:access_token]
    return render json: 'すでに連携しています', status: 400 if current_user.nature_remo.present?
    return render json: 'access_token not found', status: 400 if access_token.blank?
    @nature_remo = NatureRemoService.create_nature_remo(current_user, access_token)
    head 200
  end
end
