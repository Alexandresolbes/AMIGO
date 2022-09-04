class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.float :credit
      t.float :debit
      t.boolean :paid
      t.references :wallet, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
