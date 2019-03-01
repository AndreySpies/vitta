class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    rating = define_rating(review_params['rating'])
    @review = Review.new(title: review_params['title'], content: review_params['content'], rating: rating)
    @review.user = current_user
    @review.doctor = Doctor.find(params[:doctor_id])
    authorize @review
    if @review.save
      redirect_to @review.doctor
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to @review.doctor
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end

  def define_rating(rating)
    return 1 if rating == 'Péssima'
    return 2 if rating == 'Ruim'
    return 3 if rating == 'Poderia ser melhor'
    return 4 if rating == 'Boa'
    return 5 if rating == 'Excelente'
  end
end
