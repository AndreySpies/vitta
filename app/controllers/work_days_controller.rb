class WorkDaysController < ApplicationController

  def create
    schedule = current_user.doctor.work_schedule
    authorize WorkDay.create!(work_schedule_id: schedule.id, day: params[:week_day])
    redirect_to patients_path
  end

  def destroy
    authorize WorkDay.find(params[:id]).destroy
    redirect_to patients_path
  end

end
