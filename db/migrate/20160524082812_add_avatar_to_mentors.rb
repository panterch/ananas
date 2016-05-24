class AddAvatarToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :avatar, :string
  end
end
