class ChangeColumnsInBills < ActiveRecord::Migration[7.0]
  def change
    change_column :bills, :credit, :float, default: 0.00
    change_column :bills, :debit, :float, default: 0.00
    change_column :bills, :paid, :boolean, default: false
  end
end
