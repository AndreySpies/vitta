class ConsultationsController < ApplicationController
  helper_method :check_avaiability

  def index
    @consultations = policy_scope(Consultation.all)
    @consultations = @consultations.where("patient_id = ?", current_user.id)
  end

  def show
    @consultation = Consultation.find(params[:consultation_id])
    authorize @consultation
    @markers = [
      {
        lng: @consultation.doctor.longitude,
        lat: @consultation.doctor.latitude,
        infoWindow: { content: render_to_string(partial: "infowindow", locals: { doctor: @consultation.doctor }) }
      }]
  end

  def new
    @consultations = Consultation.all.where("doctor_id = ?", params[:doctor_id]).order(:start_time)
    @consultation = Consultation.new
    authorize @consultation
    @doctor = Doctor.find(params[:doctor_id])
    @user = User.find(current_user.id)
    if Date.parse(params[:consultation]["start_time"]) < Date.today
      redirect_to @doctor, alert: "Data inválida"
    end
  end

  def create
    @consultations = Consultation.all.where("doctor_id = ?", params[:doctor_id])
    @consultation = Consultation.new(consultation_params)
    authorize @consultation
    empty = true
    @consultation[:end_time] = params[:consultation]["start_time"].to_time + 1800
      @consultations.each do |marked_consultation|
        empty = false if (@consultation.start_time == marked_consultation.start_time)
      end
    if empty
      if params[:consultation]["start_time"] < Time.now
        redirect_to doctor_path(params[:doctor_id]), alert: "Horário inválido"
      else
        if @consultation.save
          redirect_to user_consultation_path({ user_id: current_user.id, id: params[:doctor_id], consultation_id: @consultation.id }), notice: 'Sua consulta foi marcada com sucesso!'
        else
          redirect_to doctor_path(params[:doctor_id]), alert: "Não conseguimos marcar sua consulta"
        end
      end
    else
      raise
      redirect_to doctor_path(params[:doctor_id]), alert: "Não conseguimos marcar sua consulta"
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
