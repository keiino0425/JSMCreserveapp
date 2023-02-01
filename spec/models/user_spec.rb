require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # メール、名前、エリア、カリキュラム、動画の権限の有無があれば有効な状態であること
  it "is valid with an email, name, area, curriculum, and video_available"
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address"
  # 名がなければ無効な状態であること
  it "is invalid without a name"
  # エリアがなければ無効な状態であること
  it "is invalid without an area"
  # カリキュラム内容がなければ無効な状態であること
  it "is invalid without a curriculum"
  # カリキュラム番号がなければ無効な状態であること
  it "is invalid without a curriculum_num"
  # 動画の権限の有無がなければ無効な状態であること
  it "is invalid without a video_available"
  # 住所がなければ無効な状態であること
  it "is invalid without an address"
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"
end
