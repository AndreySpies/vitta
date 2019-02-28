class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
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
    @specialties = Specialty.all
    authorize @doctor
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.user = current_user
    authorize @doctor
    if @doctor.save
      create_doctor_specialties(@doctor, params[:doctor][:specialties])
    else
      render :new
    end
  end

  private

  def create_doctor_specialties(doctor, specialties)
    specialties.delete_at(0)
    specialties.each do |specialty_id|
      specialty = Specialty.find(specialty_id.to_i)
      DoctorSpecialty.create!(doctor: doctor, specialty: specialty)
    end
    redirect_to doctor
  end

  def doctor_params
    params.require(:doctor).permit(:description, :price, :address, :crm, :specialties)
  end
end
