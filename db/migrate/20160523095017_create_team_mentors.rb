class CreateTeamMentors < ActiveRecord::Migration
  def change
    create_table :team_mentors do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :mentor, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
