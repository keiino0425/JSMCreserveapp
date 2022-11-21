class UserMailer < ApplicationMailer
  default from: 'no-reply@spaschool.jp'

  def reservation_email
    @reservation = params[:reservation]
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    mail(to: @teacher.email, subject: '新規予約が登録されました')
  end

  def reservation_delete_email
    @user = params[:user]
    @teacher = params[:teacher]
    @start_time = params[:start_time]
    mail(to: @teacher.email, subject: '予約が削除されました')
  end
end
