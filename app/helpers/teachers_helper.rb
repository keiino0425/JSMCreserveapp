module TeachersHelper
  def check_user(reservation)
    user = User.find(reservation.user_id)
    return user.user_name
  end
end
