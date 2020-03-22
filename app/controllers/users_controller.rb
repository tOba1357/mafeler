class UsersController < ApplicationController
  def show
    render json: current_user
  end

  def update
    @user = current_user
    @user.attributes = user_params
    if @user.save(context: :profile)
      render json: @user
    else
      error_message = @user.errors.full_messages.join("\n")
      render json: error_message, status: 400
    end
  end

  def saved
    @user = current_user
    render json: {profile_saved: @user.valid?(:profile)}
  end

  private
  def user_params
    params.require(:users).permit(:gender, :birthday, :height, :weight)
  end
end