class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :summary, null: false
      t.string :description
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :url

      t.timestamps null: false
    end
    add_index :events, :start_at
  end
end
