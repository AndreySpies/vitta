require 'twilio-ruby'
require 'pagarme'

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
    else
      workdays_array = []
      unless @doctor.work_schedule.empty?
        @doctor.work_schedule.work_days.each do |weekday|
          workdays_array << weekday.day
        end
      end
      unless workdays_array.include?((Date.parse(params[:consultation]["start_time"]).cwday - 1))
        redirect_to @doctor, alert: "Médico não atende este dia da semana."
      end
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
        if @consultation.valid?
          respond_to do |format|
            format.js
          end
          # send_confirmation(@consultation)
          # redirect_to user_consultation_path({ user_id: current_user.id, id: params[:doctor_id], consultation_id: @consultation.id }), notice: 'Sua consulta foi marcada com sucesso!'
        else
          redirect_to doctor_path(params[:doctor_id]), alert: "Não conseguimos marcar sua consulta"
        end
      end
    else
      redirect_to doctor_path(params[:doctor_id]), alert: "Não conseguimos marcar sua consulta"
    end
  end

  def confirm_consultation
    PagarMe.api_key        = ENV["PAGARME_API_KEY"]
    PagarMe.encryption_key = ENV["PAGARME_ENCRYPTION_KEY"]
    amount = params[:pagarme][:amount].to_i
    card_hash = params[:pagarme][:card_hash]
    admin = Admin.find(1)
    doctor = Doctor.find(params[:doctor_id])
    patient = User.find(params[:patient_id])
    start_time = params[:start_time]
    end_time = params[:end_time]
    birth_date_month = "0#{patient.birth_date.month}" if patient.birth_date.month < 10
    payment_method = params[:pagarme][:payment_method]
    @order = Order.create!(
      doctor: doctor,
      patient: patient,
      consultation_start_time: start_time,
      consultation_end_time: end_time,
      method: payment_method
    )

    transaction = PagarMe::Transaction.new({
      amount: amount,
      payment_method: "credit_card",
      card_hash: card_hash,
      split_rules: [
        { recipient_id: doctor.recipient_id, percentage: 95 },
        { recipient_id: admin.recipient_id, percentage: 5 }
      ],
      customer: {
        external_id: patient.id.to_s,
        name: "#{patient.first_name} #{patient.last_name}",
        type: "individual",
        country: "br",
        email: patient.email,
        documents: [
          {
            type: "cpf",
            number: patient.cpf
          }

        ],
        phone_numbers: ["+55#{patient.phone}"],
        birthday: "#{patient.birth_date.year}-#{birth_date_month}-#{patient.birth_date.day}"
      },
      billing: {
        name: "Vitta",
        address: {
          country: "br",
          state: "sp",
          city: "São Paulo",
          street: "Rua Mourato Coelho",
          street_number: "1404",
          zipcode: "05417002"
        }
      },
      items: [
        {
          id: @order.id.to_s,
          title: "Consultation with #{doctor.user.first_name} #{doctor.user.last_name}",
          unit_price: amount,
          quantity: 1,
          tangible: false
        }

      ]
    })

    charge = transaction.charge

    transaction = PagarMe::Transaction.find charge.id

    if transaction.status == "paid"
      @consultation = Consultation.new(price_cents: amount, patient: patient, doctor: doctor, start_time: start_time, end_time: end_time)
      @consultation.save
      @order.update!(consultation: @consultation, status: transaction.status)
      authorize @consultation
      send_confirmation(@consultation)
      redirect_to user_consultation_path({ user_id: current_user.id, id: params[:doctor_id], consultation_id: @consultation.id }), notice: 'Sua consulta foi marcada com sucesso!'
    else
      redirect_to doctor, alert: "Não foi possível marcar sua consulta"
      authorize doctor
    end

  end

  private

  def send_confirmation(consultation)
    info = consultation
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+5519933007128' # Your Twilio number
    to = "+55#{info.patient.phone}" # Your mobile phone number
    message = "Sua consulta com o(a) doutor(a) #{info.doctor.user.first_name} #{info.doctor.user.last_name} está agendada para o dia #{info.start_time.day}/#{info.start_time.month}/#{info.start_time.year} às #{info.start_time.hour}:#{sprintf '%02d',info.start_time.min}hs"

    client.messages.create(
      from: from,
      to: to,
      body: message
    )
  end

  def consultation_params
    params.require(:consultation).permit(:price_cents, :patient_id, :doctor_id, :start_time)
  end

  def check_avaiability(consultations, number)
    consultations = consultations.where("CAST(start_time AS TIME) = ?", Time.parse("#{sprintf '%02d',(number*30)/60}:#{sprintf '%02d', (number*30)%60}"))
    consultations.empty?
  end
end
