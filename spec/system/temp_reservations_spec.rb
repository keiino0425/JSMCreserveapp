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

end
