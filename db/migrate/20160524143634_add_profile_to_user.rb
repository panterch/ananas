class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :integer, null: false
    add_column :users, :profile_type, :string, null: false
    add_index :users, :profile_id
  end
end
