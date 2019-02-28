class ConsultationsController < ApplicationController

  helper_method :check_avaiability

  def index
    @consultations = policy_scope(Consultation.all)
  end

  def show
    @consultation = Consultation.find(params[:id])
    authorize @consultation
  end

  def new
    @consultations = Consultation.all.where("doctor_id = ?", params[:doctor_id]).order(:start_time)
    @consultation = Consultation.new
    authorize @consultation
    @doctor = Doctor.find(params[:doctor_id])
    @user = User.find(current_user.id)
  end

  def create
    @consultations = Consultation.all.where("doctor_id = ?", params[:doctor_id])
    @consultation = Consultation.new(consultation_params)
    authorize @consultation
    empty = true
    @consultation[:end_time] = params[:consultation]["start_time"].to_time + 1800
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
      redirect_to doctor_path(params[:doctor_id]), notice: 'Sua consulta foi marcada com sucesso!'
    else
      redirect_to new_doctor_consultation_path
    end
  end

  private

  def consultation_params
    params.require(:consultation).permit(:price_cents, :patient_id, :doctor_id, :start_time)
  end

  def check_avaiability(consultations, number)
    consultations = consultations.where("CAST(start_time AS TIME) = ?", Time.parse("#{sprintf '%02d',(number*30)/60}:#{sprintf '%02d', (number*30)%60}"))
    consultations.empty?
  end
end
