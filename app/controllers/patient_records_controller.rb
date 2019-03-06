class PatientRecordsController < ApplicationController
  def index
    @patient = User.find(params[:user_id])
    @patient_records = policy_scope(PatientRecord.where(patient: @patient))
    @patient_records = @patient_records.where(doctor: current_user.doctor)
  end

  def edit
    @patient_record = PatientRecord.find(params[:id])
    authorize @patient_record
  end
end
