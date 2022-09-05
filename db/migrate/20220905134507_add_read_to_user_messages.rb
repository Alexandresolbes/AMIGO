class AddReadToUserMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :user_messages, :read, :boolean, default: false
  end
end
