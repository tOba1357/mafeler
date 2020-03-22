class ChineseMedicineConstitutionsController < ApplicationController
  def index
    @constitutions = ChineseMedicineConstitution.all
    render json: @constitutions
  end
end
