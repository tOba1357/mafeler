class ChineseMedicineSelectionsController < ApplicationController
  def index
    @selections = ChineseMedicineSelection.all
    render json: @selections
  end

end
