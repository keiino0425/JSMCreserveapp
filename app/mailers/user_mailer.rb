class UserMailer < ApplicationMailer
  default from: 'no-reply@spaschool.jp'

  def reservation_email
    @reservation = params[:reservation]
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    mail(to: @user.email, subject: '予約が確定しました')
  end

  def reservation_delete_email
    @user = params[:user]
    @teacher = params[:teacher]
    @start_time = params[:start_time]
    mail(to: @teacher.email, subject: '予約が削除されました')
  end

  def temp_reservation_email
    @temp_reservation = params[:temp_reservation]
    @user = User.find(@temp_reservation.user_id)
    @teacher = Teacher.find(@temp_reservation.teacher_id)
    mail(to: @teacher.email, subject: '仮予約が登録されました')
  end
end
