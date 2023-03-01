require 'rails_helper'

RSpec.describe "Reservations", type: :system do
  before do
    driven_by(:rack_test)
  end

  # 講師が自分の日程を終日で登録する
  scenario "teacher register his schedule all day" do
    teacher = FactoryBot.create(:teacher)

    visit new_teacher_session_path
    fill_in "Eメール", with: teacher.email
    fill_in "パスワード", with: teacher.password
    click_button "ログイン"

    click_link "日程管理"

    time = Time.zone.now + 2.day
    tommorow = time.day

    expect {
      click_link time.day
      click_button "予約する"
      expect(page).to have_content "講師の予定を登録しました。"
    }.to change(teacher.reservations, :count).by(1)
  end

  # 講師が自分の日程を登録する
  scenario "teacher register his schedule" do
    teacher = FactoryBot.create(:teacher)

    visit new_teacher_session_path
    fill_in "Eメール", with: teacher.email
    fill_in "パスワード", with: teacher.password
    click_button "ログイン"

    click_link "日程管理"

    time = Time.zone.now.beginning_of_day + 1.day + 10.hour
    later_time = time + 90.minutes

    expect {
      fill_in "reservation[start_time]", with: time
      fill_in "reservation[end_time]", with: later_time
      click_button "日程を登録する"
      click_button "予約する"
      expect(page).to have_content "講師の予定を登録しました。"
    }.to change(teacher.reservations, :count).by(1)
  end

end
