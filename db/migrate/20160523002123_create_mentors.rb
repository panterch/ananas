class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :job_title
      t.text :who_i_am
      t.text :experience
      t.text :interests
      t.text :motivation

      t.timestamps null: false
    end
  end
end
