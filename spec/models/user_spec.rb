require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # メール、名前、エリア、カリキュラムがあれば有効な状態であること
  it "is valid with an email, name, area, and curriculum" do
    user = User.new(
      email: "tester@example.com",
      user_name: "Aaron Sumner",
      curriculum: "ヘッドスパ",
      user_address: "大阪府大阪市中央区大阪城１−１",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("translation missing: ja.activerecord.errors.models.user.attributes.email.blank")
  end
  # 名がなければ無効な状態であること
  it "is invalid without a name" do
    user = FactoryBot.build(:user, user_name: nil)
    user.valid?
    expect(user.errors[:user_name]).to include("translation missing: ja.activerecord.errors.models.user.attributes.user_name.blank")
  end
  # カリキュラム内容がなければ無効な状態であること
  it "is invalid without a curriculum" do
    user = FactoryBot.build(:user, curriculum: nil)
    user.valid?
    expect(user.errors[:curriculum]).to include("translation missing: ja.activerecord.errors.models.user.attributes.curriculum.blank")
  end
  # 住所がなければ無効な状態であること
  it "is invalid without an address" do
    user = FactoryBot.build(:user, user_address: nil)
    user.valid?
    expect(user.errors[:user_address]).to include("translation missing: ja.activerecord.errors.models.user.attributes.user_address.blank")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("translation missing: ja.activerecord.errors.models.user.attributes.email.taken")
  end
end
