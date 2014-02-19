class AddNotNullForUserId < ActiveRecord::Migration
  def change
    change_column :contacts, :user_id, :integer, :null => false
    add_index :users, :username, :unique => true
  end
end
