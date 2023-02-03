require 'rails_helper'

RSpec.describe TempReservation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:teacher) { FactoryBot.create(:teacher) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.create(:temp_reservation)).to be_valid
  end
  # ユーザーid、講師id、開始時間、終了時間、実施場所があれば有効な状態であること
  it "is valid with an user_id, teacher_id, start_time, end_time, and address" do
    time = DateTime.now.beginning_of_day + 1.day + 10.hour
    later_time = time + 90.minutes
    temp_reservation = TempReservation.new(
      user: user,
      teacher: teacher,
      start_time: time,
      end_time: later_time,
      address_select: true,
    )
    expect(temp_reservation).to be_valid
  end
  # 開始時間がなければ無効な状態であること
  it "is invalid without a start_time" do
    temp_reservation = FactoryBot.build(:temp_reservation, start_time: nil)
    temp_reservation.valid?
    expect(temp_reservation.errors[:start_time]).to include("translation missing: ja.activerecord.errors.models.temp_reservation.attributes.start_time.blank")
  end
  # 終了時間がなければ無効な状態であること
  it "is invalid without an end_time" do
    temp_reservation = FactoryBot.build(:temp_reservation, end_time: nil)
    temp_reservation.valid?
    expect(temp_reservation.errors[:end_time]).to include("translation missing: ja.activerecord.errors.models.temp_reservation.attributes.end_time.blank")
  end
  # 実施場所がなければ無効な状態であること
  it "is invalid without an address" do
    temp_reservation = FactoryBot.build(:temp_reservation, address_select: nil)
    temp_reservation.valid?
    expect(temp_reservation.errors[:address_select]).to include("translation missing: ja.activerecord.errors.models.temp_reservation.attributes.address_select.blank")
  end
end
