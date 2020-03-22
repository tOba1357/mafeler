module Admin
  class ChineseMedicineSelectionsController < Admin::ApplicationController
    def index
      @chinese_medicine_selections = ChineseMedicineSelection.all
      render json: @chinese_medicine_selections
    end

    def create
      @chinese_medicine_selection = ChineseMedicineSelection.new chinese_medicine_selections_params
      if @chinese_medicine_selection.save
        render json: @chinese_medicine_selection
      else
        error_message = @chinese_medicine_selection.errors.full_messages.join("\n")
        render json: error_message, status: 400
      end
    end

    def update
      @chinese_medicine_selection = ChineseMedicineSelection.find_by! params[:id]
      if @chinese_medicine_selection.update chinese_medicine_selections_params
        render json: @chinese_medicine_selection
      else
        error_message = @chinese_medicine_selection.errors.full_messages.join("\n")
        render json: error_message, status: 400
      end
    end

    private

    def chinese_medicine_selections_params
      params.require(:chinese_medicine_selection).permit(:chinese_medicine_constitution_id, :label)
    end
  end
end
