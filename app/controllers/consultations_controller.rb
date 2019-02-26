class ConsultationsController < ApplicationController
  def index
    @consultations = policy_scope(Consultation.all)
  end

  def show
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end

  def new
    @consultation = Consultation.new
    authorize @consultation
    @doctor = Doctor.find(params[:doctor_id])
    @user = User.find(current_user.id)
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    @consultation = Consultation.new(consultation_params)
    # @consultation = Consultation.new(patient_id: current_user.id,
    #                                  doctor_id: params[:doctor_id],
    #                                  price_cents: @doctor.price_cents)
    if @consultation.save
      redirect_to doctor_consultations_path
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:price_cents, :patient_id, :doctor_id, :start_time, :end_time)
  end
end
