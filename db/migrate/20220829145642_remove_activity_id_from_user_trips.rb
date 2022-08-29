class RemoveActivityIdFromUserTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_trips, :activity_id, :integer
  end
end
