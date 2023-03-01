require 'rails_helper'

RSpec.describe Teacher, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:teacher)).to be_valid
  end
  # メール、名前、エリア、画像、カリキュラムがあれば有効な状態であること
  it "is valid with an email, name, area, image, and curriculum" do
    teacher = Teacher.new(
      email: "tester@example.com",
      teacher_name: "Emily Johnson",
      teacher_area: "九州",
      teacher_img: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/files/test.jpeg')),
      teacher_address: "熊本県熊本市中央区本丸１−１",
      password: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(teacher).to be_valid
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    teacher = FactoryBot.build(:teacher, email: nil)
    teacher.valid?
    expect(teacher.errors[:email]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.email.blank")
  end
  # 名がなければ無効な状態であること
  it "is invalid without a name" do
    teacher = FactoryBot.build(:teacher, teacher_name: nil)
    teacher.valid?
    expect(teacher.errors[:teacher_name]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.teacher_name.blank")
  end
  # エリアがなければ無効な状態であること
  it "is invalid without a curriculum" do
    teacher = FactoryBot.build(:teacher, teacher_area: nil)
    teacher.valid?
    expect(teacher.errors[:teacher_area]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.teacher_area.blank")
  end
  # 画像がなければ無効な状態であること
  it "is invalid without a image" do
    teacher = FactoryBot.build(:teacher, teacher_img: nil)
    teacher.valid?
    expect(teacher.errors[:teacher_img]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.teacher_img.blank")
  end
  # 住所がなければ無効な状態であること
  it "is invalid without an address" do
    teacher = FactoryBot.build(:teacher, teacher_address: nil)
    teacher.valid?
    expect(teacher.errors[:teacher_address]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.teacher_address.blank")
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:teacher, email: "aaron@example.com")
    teacher = FactoryBot.build(:teacher, email: "aaron@example.com")
    teacher.valid?
    expect(teacher.errors[:email]).to include("translation missing: ja.activerecord.errors.models.teacher.attributes.email.taken")
  end
end
