module TeachersHelper
  def check_user(reservation)
    user = User.find(reservation.user_id)
    user.user_name
  end

  def user_address(reservation)
    user = User.find(reservation.user_id)
    user.user_address
  end
end
