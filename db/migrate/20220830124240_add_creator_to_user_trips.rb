class AddCreatorToUserTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :user_trips, :creator, :boolean, default: false
  end
end
