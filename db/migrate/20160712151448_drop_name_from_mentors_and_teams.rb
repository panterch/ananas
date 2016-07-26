class DropNameFromMentorsAndTeams < ActiveRecord::Migration
  def change
    remove_column :mentors, :name, :string
    remove_column :teams, :name, :string
  end
end
