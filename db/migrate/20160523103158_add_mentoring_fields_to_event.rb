class AddMentoringFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :type, :string
    add_index :events, :type
    add_column :events, :mentor_id, :integer
    add_index :events, :mentor_id
    add_column :events, :team_id, :integer
    add_index :events, :team_id
  end
end
