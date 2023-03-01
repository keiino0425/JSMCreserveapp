FactoryBot.define do
  factory :teacher do
    sequence(:email) { |n| "tester#{n}@example.com" }
    teacher_name {"Emily Johnson"}
    teacher_area { "九州" }
    teacher_img { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/files/test.jpeg')) }
    teacher_address { "熊本県熊本市中央区本丸１−１" }
    password { "dottle-nouveau-pavilion-tights-furze" }
  end
end
