class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :credit
      t.float :debit
      t.references :user_trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
