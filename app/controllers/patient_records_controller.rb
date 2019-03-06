class PatientRecordsController < ApplicationController
  before_action :set_patient_record, only: %i[edit update]

  def index
    @patient = User.find(params[:user_id])
    @patient_records = policy_scope(PatientRecord.where(patient: @patient))
    @patient_records = @patient_records.where(doctor: current_user.doctor)
  end

  def new
    @user = User.find(params[:user_id])
    @patient_record = PatientRecord.new
    authorize @patient_record
  end

  def create
    patient = User.find(params[:user_id])
    @patient_record = PatientRecord.new(patient_record_params)
    @patient_record.patient = patient
    @patient_record.doctor = current_user.doctor
    authorize @patient_record
    if @patient_record.save
      redirect_to user_patient_records_path(@patient_record.patient), notice: 'Prontuário criado com sucesso!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @patient_record.update(patient_record_params)
      redirect_to user_patient_records_path(@patient_record.patient), notice: 'Prontuário atualizado com sucesso!'
    else
      render :edit
    end
  end

  private

  def set_patient_record
    @patient_record = PatientRecord.find(params[:id])
    authorize @patient_record
  end

  def patient_record_params
    params.require(:patient_record).permit(:entry)
  end
end
