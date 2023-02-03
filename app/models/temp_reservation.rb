class TempReservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :teacher
  has_one :reservation

  validates :user_id, :teacher_id, :start_time, :end_time, :address_select, presence: true

  def self.check_reservation_day(user_id, start_time)
    same_user_temp_reservation = TempReservation.where(user_id: user_id)
    same_user_reservation = Reservation.where(user_id: user_id)
    temp_start = same_user_temp_reservation.map(&:start_time)
    start = same_user_reservation.map(&:start_time)

    temp_start.each do |i|
      if start_time < (i + 8.days)
        return "仮予約との間隔が1週間以内のため予約できません。"
      end
    end

    start.each do |i|
      if start_time < (i + 8.days)
        return "予約との間隔が1週間以内のため予約できません。"
      end
    end

    if start_time < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif start_time < (Date.current + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < start_time
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end
end
