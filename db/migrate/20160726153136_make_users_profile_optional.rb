class MakeUsersProfileOptional < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :profile_id, :integer, null: true
    change_column :users, :profile_type, :string, null: true
  end

  def down
    change_column :users, :profile_id, :integer, null: false
    change_column :users, :profile_type, :string, null: false
  end
end
