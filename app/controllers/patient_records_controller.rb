class PatientRecordsController < ApplicationController
  def show
    @patient = User.find(params[:user_id])
    @patient_records = PatientRecord.where(user: @patient)
    authorize @patient_records
    # @patient = User.find(params[:user_id])
  end
end
