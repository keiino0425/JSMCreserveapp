FactoryBot.define do
  time = Time.zone.now.beginning_of_day + 1.day + 10.hour
  later_time = time + 90.minutes
  week_time = time + 6.day
  week_later_time = week_time + 90.minutes
  yesterday_time = time - 2.day
  yesterday_later_time = yesterday_time + 90.minutes
  today_time = time - 1.day
  today_later_time = today_time + 90.minutes
  month_time = today_time + 1.month
  month_later_time = month_time + 90.minutes
  
  factory :temp_reservation do
    association :user, strategy: :create
    association :teacher, strategy: :create
    start_time { time }
    end_time { later_time }
    address_select { true }

    #開始時間が1週間以内
    trait :start_week do
      start_time { week_time }
      end_time { week_later_time }
    end

    #開始時間が昨日以降
    trait :start_yesterday do
      start_time { yesterday_time }
      end_time { yesterday_later_time }
    end

    #開始時間が今日
    trait :start_today do
      start_time { today_time }
      end_time { today_later_time }
    end

    #開始時間が1ヶ月先以降
    trait :start_month do
      start_time { month_time }
      end_time { month_later_time }
    end
  end
end
