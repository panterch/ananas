class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
