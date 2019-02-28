class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  def index
    @doctors = policy_scope(Doctor.near('Sapiranga'))
    @doctors = Doctor.global_search(params[:keywords]) if params[:keywords].present?

    @markers = @doctors.map do |doctor|
      {
        lng: doctor.longitude,
        lat: doctor.latitude,
        infoWindow: { content: render_to_string(partial: "infowindow", locals: { doctor: doctor }) }
      }
    end
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
    @doctor.user = current_user
    authorize @doctor
    if @doctor.save
      redirect_to doctors_path
    else
      render :new
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:description, :price, :address, :crm)
  end
end
