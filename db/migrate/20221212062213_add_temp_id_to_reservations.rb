class AddTempIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :temp_reservation_id, :bigint, null: false
  end
end
