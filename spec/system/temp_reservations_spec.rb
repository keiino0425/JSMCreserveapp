require 'rails_helper'

RSpec.describe "TempReservations", type: :system do
  before do
    driven_by(:rack_test)
  end

  # 生徒が仮予約を作成する
  scenario "user temp reserve" do
    user = FactoryBot.create(:user)
    teacher = FactoryBot.create(:teacher)
    reservation = FactoryBot.create(:reservation, teacher_id: teacher.id)

    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      click_link "カリキュラム予約"
      click_link teacher.teacher_name
      click_link "○", match: :first
      click_button "予約する"
      expect(page).to have_content "仮予約が完了いたしました。3営業日以内に予約の可否についてメールでご連絡いたします。"
    }.to change(user.temp_reservations, :count).by(1)
  end

  #講師が仮予約を確定させる
  scenario "teacher confirms temp reservation" do
    user = FactoryBot.create(:user)
    teacher = FactoryBot.create(:teacher)
    temp_reservation = FactoryBot.create(:temp_reservation, user_id: user.id, teacher_id: teacher.id)

    visit new_teacher_session_path
    fill_in "Eメール", with: teacher.email
    fill_in "パスワード", with: teacher.password
    click_button "ログイン"

    expect {
      click_link "確定"
      click_button "予約する"
    }.to change(teacher.reservations, :count).by(1), change(teacher.temp_reservations, :count).by(-1)
  end

  #講師が仮予約をキャンセルする
  scenario "teacher cancels temp reservations" do
    user = FactoryBot.create(:user)
    teacher = FactoryBot.create(:teacher)
    temp_reservation = FactoryBot.create(:temp_reservation, user_id: user.id, teacher_id: teacher.id)

    visit new_teacher_session_path
    fill_in "Eメール", with: teacher.email
    fill_in "パスワード", with: teacher.password
    click_button "ログイン"

    expect {
      click_button "削除"
      expect(page).to have_content "仮予約を削除しました。"
    }.to change(teacher.temp_reservations, :count).by(-1)
  end

  #生徒が仮予約をキャンセルする
  scenario "user canceles temp reservations" do
    user = FactoryBot.create(:user)
    teacher = FactoryBot.create(:teacher)
    temp_reservation = FactoryBot.create(:temp_reservation, user_id: user.id, teacher_id: teacher.id)

    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      save_page
      click_button "削除"
      expect(page).to have_content "仮予約を削除しました。"
    }.to change(user.temp_reservations, :count).by(-1)
  end
end
