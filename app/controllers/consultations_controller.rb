class ConsultationsController < ApplicationController
  def index
    @consultations = policy_scope(Consultation.all)
  end

  def show
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end

  def new
    @consultations = Consultation.all.where("doctor_id = #{params[:doctor_id]}")
    @consultation = Consultation.new
    authorize @consultation
    @doctor = Doctor.find(params[:doctor_id])
    @user = User.find(current_user.id)
  end

  def create
    @consultations = Consultation.all.where("doctor_id = #{params[:doctor_id]}")
    @doctor = Doctor.find(params[:doctor_id])
    @consultation = Consultation.new(consultation_params)
    authorize @consultation
    empty = true
    if @consultation.start_time < @consultation.end_time
      @consultations.each do |marked_consultation|
        if (@consultation.start_time == marked_consultation.start_time) && (@consultation.end_time == marked_consultation.end_time)
          empty = false
        elsif (@consultation.start_time > marked_consultation.start_time) && (@consultation.start_time < marked_consultation.start_time)
          empty = false
        else
          if (@consultation.end_time > marked_consultation.start_time) && (@consultation.end_time < marked_consultation.end_time)
            empty = false
          else
            if (@consultation.start_time < marked_consultation.start_time) && (@consultation.end_time > marked_consultation.end_time)
              empty = false
            end
          end
        end
      end
    else
      empty = false
    end
    if empty
      @consultation.save
      redirect_to doctor_consultations_path(params[:doctor_id])
    else
      redirect_to new_doctor_consultation_path
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:price_cents, :patient_id, :doctor_id, :start_time, :end_time)
  end


end
