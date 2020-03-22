class DiariesController < ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    page = params[:page] || 1
    @diaries = Diary.where(user: current_user).order(date: :DESC).page(page)
    render json: {diaries: @diaries, page: page, total_page: @diaries.total_pages}
  end

  def show
    render json: @diary.to_form_hash
  end

  def create
    @service = DiarySaveService.new(current_user)
    if @service.save(params)
      res = @service.diary.to_form_hash
      res[:alert_warnings] = [current_user.diaries_warning]
      render json: res
    else
      error_message = @service.errors.join("\n")
      render json: error_message, status: 400
    end
  end

  def update
    @service = DiarySaveService.new(current_user, @diary)
    if @service.save(params)
      res = @service.diary.to_form_hash
      res[:alert_warnings] = [current_user.diaries_warning]
      render json: res
    else
      error_message = @service.errors.join("\n")
      render json: error_message, status: 400
    end
  end

  def destroy
    if @diary.destroy
      head :ok
    else
      error_message = @diary.errors.full_messages.join("\n")
      render json: error_message, status: 400
    end
  end

  private

  def set_diary
    @diary = current_user.diaries.includes(:sleeps).find_by!(date: params[:date])
  end
end
