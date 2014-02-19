class AddColumn < ActiveRecord::Migration
  def change
    add_column :contacts, :user_id, :integer
    add_index :contacts, [:email, :user_id], :unique => true
  end
end
