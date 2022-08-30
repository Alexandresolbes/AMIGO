class AddCreatorToParticipations < ActiveRecord::Migration[7.0]
  def change
    add_column :participations, :creator, :boolean, default: false
  end
end
