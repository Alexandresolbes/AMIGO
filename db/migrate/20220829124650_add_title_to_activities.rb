class AddTitleToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :title, :string
  end
end
