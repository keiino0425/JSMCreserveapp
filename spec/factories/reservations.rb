FactoryBot.define do
  factory :reservation do
    association :temp_reservation
    user { temp_reservation.user }
    teacher { temp_reservation.teacher }
    start_time { temp_reservation.start_time }
    end_time { temp_reservation.end_time }
    address_select { temp_reservation.address_select }
  end
end
