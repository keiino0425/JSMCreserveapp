class AddEndtimeToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :end_time, :datetime, null: false
  end
end
