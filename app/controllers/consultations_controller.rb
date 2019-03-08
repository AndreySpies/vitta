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

    doctor = Doctor.find(params[:doctor_id])
    patient = User.find(params[:patient_id])
    start_time = params[:start_time]
    end_time = params[:end_time]

    # PagarMe::Transaction.new(amount: amount, card_hash: card_hash).charge
    transaction = PagarMe::Transaction.new({
  amount: amount,
  payment_method: "credit_card",
  card_hash: card_hash,
  customer: {
    external_id: "#3311",
    name: "#{patient.first_name} #{patient.last_name}",
    type: "individual",
    country: "br",
    email: patient.email,
    documents: [
      {
        type: "rg",
        number: patient.rg
      }

    ],
    phone_numbers: ["+55#{patient.phone}"],
    birthday: "1965-01-01"
  },
  billing: {
    name: "Trinity Moss",
    address: {
      country: "br",
      state: "sp",
      city: "Cotia",
      neighborhood: "Rio Cotia",
      street: "Rua Matrix",
      street_number: "9999",
      zipcode: "06714360"
    }
  },
  items: [
    {
      id: "",
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
      authorize @consultation
      # send_confirmation(@consultation)
      redirect_to user_consultation_path({ user_id: current_user.id, id: params[:doctor_id], consultation_id: @consultation.id }), notice: 'Sua consulta foi marcada com sucesso!'
    else
      raise
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
