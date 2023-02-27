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

  describe "#teacher_index" do
    before do
      @teacher = FactoryBot.create(:teacher)
    end
    # 認証済みの講師として
    context "as an authenticated teacher" do
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @teacher
        get :teacher_index, params: { teacher_id: @teacher.id }
        expect(response).to be_successful
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @teacher
        get :teacher_index, params: { teacher_id: @teacher.id }
        expect(response).to have_http_status "200"
      end
    end

    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        get :teacher_index, params: { teacher_id: @teacher.id }
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        get :teacher_index, params: { teacher_id: @teacher.id }
        expect(response).to redirect_to "/teachers/sign_in"
      end
    end
  end

  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      context "with valid attributes" do
        it "adds a reservation" do
          reservation_params = FactoryBot.build(:reservation, :user_reservation).attributes
          @user = User.find_by(id: reservation_params["user_id"])
          @teacher = Teacher.find_by(id: reservation_params["teacher_id"])
          sign_in @user
          expect {
            post :create, params: { user_id: @user.id, teacher_id: @teacher.id, reservation: reservation_params }
          }.to change(@user.reservations, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not add a project" do
          reservation_params = FactoryBot.create(:reservation, :user_reservation).attributes
          sign_in @user
          expect {
            post :create, params: { reservation: reservation_params }
          }.to_not change(@user.reservations, :count).by(1)
        end
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        reservation_params = FactoryBot.create(:reservation, :user_reservation).attributes
        post :create, params: { reservation: reservation_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        reservation_params = FactoryBot.create(:reservation, :user_reservation).attributes
        post :create, params: { reservation: reservation_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
