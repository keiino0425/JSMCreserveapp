require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:teacher) { FactoryBot.create(:teacher) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.create(:reservation)).to be_valid
  end
  # 講師id、開始時間、終了時間、実施場所があれば有効な状態であること
  it "is valid with an user_id, teacher_id, start_time, end_time, and address" do
    time = DateTime.now.beginning_of_day + 1.day + 10.hour
    later_time = time + 90.minutes
    reservation = Reservation.new(
      teacher: teacher,
      start_time: time,
      end_time: later_time,
      address_select: true,
    )
    expect(reservation).to be_valid
  end
  # 開始時間がなければ無効な状態であること
  it "is invalid without a start_time" do
    reservation = FactoryBot.build(:reservation, :user_reservation, start_time: nil)
    reservation.valid?
    expect(reservation.errors[:start_time]).to include("translation missing: ja.activerecord.errors.models.reservation.attributes.start_time.blank")
  end
  # 終了時間がなければ無効な状態であること
  it "is invalid without a end_time" do
    reservation = FactoryBot.build(:reservation, :user_reservation, end_time: nil)
    reservation.valid?
    expect(reservation.errors[:end_time]).to include("translation missing: ja.activerecord.errors.models.reservation.attributes.end_time.blank")
  end
  # 実施場所がなければ無効な状態であること
  it "is invalid without an address" do
    reservation = FactoryBot.build(:reservation, :user_reservation, address_select: nil)
    reservation.valid?
    expect(reservation.errors[:address_select]).to include("translation missing: ja.activerecord.errors.models.reservation.attributes.address_select.blank")
  end
  # 開始時間が昨日以前なら無効な状態であること
  it "is invalid when start time is before yesterday" do
    reservation = FactoryBot.build(:reservation, :start_yesterday)
    expect(Reservation.check_reservation_day(reservation.start_time)).to include("過去の日付は選択できません。正しい日付を選択してください。")
  end
  # 開始時間が今日なら無効な状態であること
  it "is invalid when start time is today" do
    reservation = FactoryBot.build(:reservation, :start_today)
    expect(Reservation.check_reservation_day(reservation.start_time)).to include("当日は選択できません。正しい日付を選択してください。")
  end
  # 開始時間が昨日以前なら無効な状態であること
  it "is invalid when start time is three months later" do
    reservation = FactoryBot.build(:reservation, :start_three_months)
    expect(Reservation.check_reservation_day(reservation.start_time)).to include("3ヶ月以降の日付は選択できません。正しい日付を選択してください。")
  end
end
