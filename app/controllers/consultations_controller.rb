class ConsultationsController < ApplicationController
  def index
    @consultations = Consultation.all
  end

  def show
    @consultation = Consultation.find(params[:id])
  end

  def new
    @consultation = Consultation.new
    @doctor = Doctor.find(params[:doctor_id])
    @user = User.find(current_user.id)
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @consultation = Consultation.new(patient_id: current_user.id,
                                     doctor_id: params[:doctor_id],
                                     price_cents: @doctor.price_cents)
    @consultation.save
    redirect_to doctor_consultations_path
  end

  private

  def consultation_params
    params.require(:consultation).permit(:price_cents, :patient, :doctor)
  end
end
