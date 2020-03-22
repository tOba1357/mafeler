class UserDefinedItemsController < ApplicationController
  def index
    render json: current_user.user_defined_items
  end

  def create
    @udi = current_user.user_defined_items.build(user_defined_item_param)
    if @udi.save
      render json: @udi
    else
      error_message = @udi.errors.full_messages.join("\n")
      render json: error_message, status: 400
    end
  end

  def update
    @udi = current_user.user_defined_items.find_by!(id: params[:id])
    if @udi.update(user_defined_item_param)
      render json: @udi
    else
      error_message = @udi.errors.full_messages.join("\n")
      render json: error_message, status: 400
    end
  end

  def destroy
    @udi = current_user.user_defined_items.find_by!(id: params[:id])
    if @udi.destroy
      render json: @udi
    else
      error_message = @udi.errors.full_messages.join("\n")
      render json: error_message, status: 400
    end
  end

  private

  def user_defined_item_param
    params.permit(:name, :value_type)
  end
end
