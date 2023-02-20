FactoryBot.define do
  time = Time.zone.now.beginning_of_day + 1.day + 10.hour
  later_time = time + 90.minutes
  today_time = Time.zone.now.beginning_of_day + 10.hour
  three_months_time = today_time + 3.month
  three_months_later_time = three_months_time + 90.minutes

  factory :reservation do
    association :teacher
    start_time { time }
    end_time { later_time }
    address_select { true }

    #生徒の予約
    trait :user_reservation do
      association :temp_reservation
      user { temp_reservation.user }
      teacher { temp_reservation.teacher }
      start_time { temp_reservation.start_time }
      end_time { temp_reservation.end_time }
      address_select { temp_reservation.address_select }
    end

    #開始時間が昨日以降
    trait :start_yesterday do
      association :temp_reservation, :start_yesterday
      user { temp_reservation.user }
      teacher { temp_reservation.teacher }
      start_time { temp_reservation.start_time }
      end_time { temp_reservation.end_time }
      address_select { temp_reservation.address_select }
    end

    #開始時間が今日
    trait :start_today do
      association :temp_reservation, :start_today
      user { temp_reservation.user }
      teacher { temp_reservation.teacher }
      start_time { temp_reservation.start_time }
      end_time { temp_reservation.end_time }
      address_select { temp_reservation.address_select }
    end

    # 開始時間が3ヶ月先以降
    trait :start_three_months do
      start_time { three_months_time }
      end_time { three_months_later_time }
    end
  end
end
