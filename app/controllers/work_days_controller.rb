class WorkDaysController < ApplicationController

  def create
    schedule = current_user.doctor.work_schedule
    if schedule.work_days.where("day = #{params[:week_day]}").empty?
      authorize WorkDay.create!(work_schedule_id: schedule.id, day: params[:week_day])
      redirect_to patients_path, notice: "Dia marcado com sucesso"
    else
      authorize WorkDay
      redirect_to patients_path, alert: "Dia já reservado"
    end
  end

  def destroy
    authorize WorkDay.find(params[:id]).destroy
    redirect_to patients_path, notice: "Dia removido com sucesso"
  end

end
