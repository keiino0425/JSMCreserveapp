FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester#{n}@example.com" }
    user_name {"Aaron Sumner"}
    user_area { "近畿" }
    curriculum { "ヘッドスパ" }
    curriculum_num { 1 }
    video_available { true }
    user_address { "大阪府大阪市中央区大阪城１−１" }
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end
