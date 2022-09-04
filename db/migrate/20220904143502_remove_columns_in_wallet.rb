class RemoveColumnsInWallet < ActiveRecord::Migration[7.0]
  def change
    remove_column :wallets, :debit, :float
    remove_column :wallets, :credit, :float
  end
end
