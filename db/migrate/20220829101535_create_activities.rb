class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :address
      t.string :categories
      t.text :description
      t.integer :min_amigos
      t.integer :max_amigos
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
