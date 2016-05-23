class AddNameToMentor < ActiveRecord::Migration
  def change
    add_column :mentors, :name, :string
  end
end
