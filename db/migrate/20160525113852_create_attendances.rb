class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :event, index: true, foreign_key: true
      t.integer :state, default: 0
      t.references :guest, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
