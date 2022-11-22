class ReservationsController < ApplicationController
  before_action :authenticate_user!, except: [:teacher_index, :teacher_new, :teacher_show, :teacher_create]
  def index
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).where(teacher_id: params[:teacher_id]).order(start_time: :desc)
    @teacher = Teacher.find(params[:teacher_id])
  end

  def teacher_index
    @reservation = Reservation.new
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).where(teacher_id: current_teacher.id).order(start_time: :desc)
    @teacher = Teacher.find(current_teacher.id)
  end

  def choice
    @teachers = Teacher.all
  end

  def new
    @user = current_user
    @teacher = Teacher.find(params[:teacher_id])
    @reservation = Reservation.new
    @teacher_id = params[:teacher_id]
    @start_time = Time.zone.parse(params[:day] + " " + params[:time] + " " + "JST")
    @end_time = @start_time + 90.minutes
    message = Reservation.check_reservation_day(@start_time)
    if !!message
      redirect_to user_teacher_reservations_path(@user.id, @teacher.id), flash: { alert: message }
    end
  end

  def teacher_new
    @reservation = Reservation.new(reservation_teacher_params)
    message = Reservation.check_reservation_day(@reservation.start_time)
    if !!message
      redirect_to teacher_reservations_index_path(current_teacher.id), flash: { alert: message }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def teacher_show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      UserMailer.with(reservation: @reservation).reservation_email.deliver_later
      redirect_to user_teacher_reservation_path(@reservation.user_id, @reservation.teacher_id, @reservation.id)
    else
      render :new
    end
  end

  def teacher_create
    @reservation = Reservation.new(reservation_teacher_params)
    if @reservation.save
      redirect_to "/teachers/#{@reservation.teacher_id}/reservations/#{@reservation.id}"
    else
      render :teacher_new
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    @start_time = @reservation.start_time
    if @reservation.destroy
      UserMailer.with(user: @user, teacher: @teacher, start_time: @start_time).reservation_delete_email.deliver_later
      flash[:success] = "予約を削除しました。"
      redirect_to user_path(current_user.id)
    else
      render "users/show"
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :teacher_id, :start_time, :end_time)
  end

  def reservation_teacher_params
    params.require(:reservation).permit(:teacher_id, :start_time, :end_time)
  end
end
