class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.doctor = Doctor.find(params[:doctor_id])
    authorize @review
    if @review.save
      redirect_to @review.doctor
    else
      flash[:alert] = 'Something went wrong.'
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
