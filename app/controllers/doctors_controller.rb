class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @latitude = params[:latitude]
    @longitude = params[:longitude]
    if params[:keywords].empty?
      @doctors = policy_scope(Doctor.all)
    else
      @doctors = policy_scope(Doctor.global_search(params[:keywords]).near([@latitude, @longitude], 50))
    end
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
    @reviews = Review.where(doctor: @doctor)
    @general_rating = set_rating(@reviews)
    authorize @doctor
    @review = Review.new
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

  def set_rating(reviews)
    if reviews.size >= 1
      rating_sum = 0
      reviews.each do |review|
        rating_sum += review.rating
      end
      rating = rating_sum / reviews.size if reviews.size >= 1
      rating
    else
      return 0
    end
  end

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
