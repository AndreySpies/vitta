class DoctorsController < ApplicationController
  def index
    @doctors = policy_scope(Doctor.all)
  end

  def show
    @consultation = Consultation.new
    @doctor = Doctor.find(params[:id])
    authorize @doctor
  end

  def new
    @doctor = Doctor.new
    authorize @doctor
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.save
    authorize @doctor
  end

  private

  def doctor_params
    params.require(:doctor).permit(:description, :price, :address, :crm)
  end
end
