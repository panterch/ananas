class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :team, index: true, foreign_key: true
      t.belongs_to :event, index: true, foreign_key: true
      t.belongs_to :mentor, index: true, foreign_key: true
      t.json :votes
      t.text :comment

      t.timestamps null: false
    end
  end
end
