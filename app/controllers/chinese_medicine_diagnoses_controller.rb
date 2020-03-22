class ChineseMedicineDiagnosesController < ApplicationController
  def index
    @diagnoses = current_user.chinese_medicine_diagnoses
    render json: @diagnoses.as_json(include: [:chinese_medicine_constitutions])
  end

  def create
    selection_ids = diagnosis_params[:selection_ids]
    if selection_ids.blank?
      return render json: 'selection ids is blank', status: 400
    end
    ActiveRecord::Base.transaction do
      @diagnosis = current_user.chinese_medicine_diagnoses.build
      @diagnosis.save!
      @selections = ChineseMedicineSelection.where(id: selection_ids).to_a
      @user_selections = @selections.map do |selection|
        @diagnosis.diagnosis_chinese_medicine_selections.build(chinese_medicine_selection: selection)
      end
      DiagnosisChineseMedicineSelection.import(@user_selections)
      @user_constitutions = @selections
        .group_by(&:chinese_medicine_constitution_id)
        .select {|_, selections| selections.size >= 3} # TODO: check min selection
        .map {|constitution_id, _| @diagnosis.diagnosis_chinese_medicine_constitutions.build(chinese_medicine_constitution_id: constitution_id)}
      DiagnosisChineseMedicineConstitution.import(@user_constitutions)
    end
    render json: @diagnosis.to_json(includes: [:chinese_medicine_constitutions])
  end

  private

  def diagnosis_params
    params.require(:diagnosis).permit(selection_ids: [])
  end
end
