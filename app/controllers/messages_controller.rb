class MessagesController < ApplicationController
  def create
    patient = User.find(params[:user_id])
    message = Message.new(message_params)
    message.patient = patient
    message.doctor = current_user.doctor
    message.save
    authorize message
    send_message(message)
    redirect_to user_patient_records_path(message.patient), notice: 'Sua mensagem foi enviada com sucesso!'
  end

  def send_message(doctor_message)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)
    from = '+5519933007128' # Your Twilio number
    to = "+55#{doctor_message.patient.phone}" # Your mobile phone number
    message = "Mensagem de #{doctor_message.doctor.user.first_name} #{doctor_message.doctor.user.last_name}: #{doctor_message.content}"
    client.messages.create(
      from: from,
      to: to,
      body: message
    )
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
