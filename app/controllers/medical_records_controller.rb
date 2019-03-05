class MedicalRecordsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @medical_records = MedicalRecord.find_by(user: @user)
    authorize @medical_records
  end

  def edit
  end
end
