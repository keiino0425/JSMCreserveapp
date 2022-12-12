class TempReservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :teacher
  has_one :reservation
  def self.check_reservation_day(start_time)
    if start_time < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif start_time < (Date.current + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < start_time
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end
end
