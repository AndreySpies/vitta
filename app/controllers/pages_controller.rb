class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    @searchArray = []
    Specialty.all.each do |specialty|
      @searchArray << specialty[:name]
    end
    Doctor.all.each do |doctor|
      @searchArray << doctor.user[:first_name]
      @searchArray << doctor.user[:last_name]
    end
  end

  def about
  end
end
