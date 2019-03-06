class MedicalRecordsController < ApplicationController
  before_action :set_record

  def show
    @medical_records = MedicalRecord.find(params[:id])
    authorize @medical_records
  end

  def edit
    @medical_record = MedicalRecord.find(params[:id])
    authorize @medical_record
  end

  def update
    @medical_record.update(medical_records_params)
    authorize @medical_record
    redirect_to @medical_record
  end

  private

  def set_record
    @medical_record = MedicalRecord.find(params[:id])
  end

  def medical_records_params
    params.require(:medical_record).permit(:blood, :allergies)
  end
end
