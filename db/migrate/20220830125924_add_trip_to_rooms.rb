class AddTripToRooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :trip, null: false, foreign_key: true
  end
end
