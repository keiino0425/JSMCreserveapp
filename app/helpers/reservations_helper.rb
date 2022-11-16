module ReservationsHelper
  def times
    times = ["9:00",
             "9:30",
             "10:00",
             "10:30",
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30",
             "18:00",
             "19:00",
             "19:30",
             "20:00"
            ]
  end

  def check_reservation(reservations, day, time)
    result = false
    reservations_count = reservations.count
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= Time.zone.parse(day + " " + time + " " + "JST") && Time.zone.parse(day + " " + time + " " + "JST") <= reservation[:end_time]
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:start_time] <= Time.zone.parse(day + " " + time + " " + "JST") && Time.zone.parse(day + " " + time + " " + "JST") <= reservations[0][:end_time]
      return result if result
    end
    return result
  end
end
