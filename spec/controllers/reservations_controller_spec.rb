require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe "#index" do
    before do
      @user = FactoryBot.create(:user)
      @teacher = FactoryBot.create(:teacher)
    end
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :index, params: { user_id: @user.id, teacher_id: @teacher.id }
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @user
        get :index, params: { user_id: @user.id, teacher_id: @teacher.id }
        expect(response).to have_http_status "200"
      end
    end
    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        get :index, params: { user_id: @user.id, teacher_id: @teacher.id }
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        get :index, params: { user_id: @user.id, teacher_id: @teacher.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
