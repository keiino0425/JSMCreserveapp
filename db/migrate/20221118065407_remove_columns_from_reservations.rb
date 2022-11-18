class RemoveColumnsFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :day, :date
    remove_column :reservations, :time, :string
  end
end
