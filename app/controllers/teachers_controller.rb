class TeachersController < ApplicationController
  before_action :authenticate_teacher!
  
  def show
    @teacher = current_teacher
    @teacher_reservations = @teacher.reservations.where("user_id IS NOT NULL").where("start_time >= ?", DateTime.current).order(:start_time)
    @temp_reservations = @teacher.temp_reservations.where("user_id IS NOT NULL").where("start_time >= ?", DateTime.current).order(:start_time)
  end
end
