FactoryBot.define do
  time = DateTime.now.beginning_of_day + 1.day + 10.hour
  later_time = time + 90.minutes
  factory :temp_reservation do
    association :user
    association :teacher
    start_time { time }
    end_time { later_time }
    address_select { true }
  end
end
