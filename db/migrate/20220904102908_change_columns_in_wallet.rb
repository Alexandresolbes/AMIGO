class ChangeColumnsInWallet < ActiveRecord::Migration[7.0]
  def change
    change_column :wallets, :credit, :float, default: 0.00
    change_column :wallets, :debit, :float, default: 0.00
  end
end
