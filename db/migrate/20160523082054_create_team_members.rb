class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :member, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
