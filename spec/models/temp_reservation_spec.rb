require 'rails_helper'

RSpec.describe TempReservation, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:teacher) { FactoryBot.create(:teacher) }

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:temp_reservation)).to be_valid
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
  # 同じ生徒の仮予約が1週間以内にあれば無効な状態であること
  it "is invalid when a temp_reservation of same user is within a week" do
    FactoryBot.build(:temp_reservation)
    temp_reservation = FactoryBot.create(:temp_reservation, :start_week)
    expect(TempReservation.check_reservation_day(temp_reservation.user_id, temp_reservation.start_time)).to include("仮予約との間隔が1週間以内のため予約できません。")
  end
  # 同じ生徒の予約が1週間以内にあれば無効な状態であること
  it "is invalid when a reservation of same user is within a week" do
    FactoryBot.build(:reservation)
    temp_reservation = FactoryBot.create(:temp_reservation, :start_week)
    expect(TempReservation.check_reservation_day(temp_reservation.user_id, temp_reservation.start_time)).to include("予約との間隔が1週間以内のため予約できません。")
  end
  # 開始時間が昨日以前なら無効な状態であること
  it "is invalid when start time is before yesterday" do
    temp_reservation = FactoryBot.build(:temp_reservation, :start_yesterday)
    expect(TempReservation.check_reservation_day(temp_reservation.user_id, temp_reservation.start_time)).to include("過去の日付は選択できません。正しい日付を選択してください。")
  end
  # 開始時間が今日なら無効な状態であること
  it "is invalid when start time is today" do
    temp_reservation = FactoryBot.build(:temp_reservation, :start_today)
    expect(TempReservation.check_reservation_day(temp_reservation.user_id, temp_reservation.start_time)).to include("当日は選択できません。正しい日付を選択してください。")
  end
  # 開始時間が1ヶ月後なら無効な状態であること
  it "is invalid when start time is one month later" do
    temp_reservation = FactoryBot.build(:temp_reservation, :start_month)
    expect(TempReservation.check_reservation_day(temp_reservation.user_id, temp_reservation.start_time)).to include("1ヶ月以降の日付は選択できません。正しい日付を選択してください。")
  end
end
