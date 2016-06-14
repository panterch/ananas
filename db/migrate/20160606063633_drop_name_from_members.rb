class DropNameFromMembers < ActiveRecord::Migration
  def up
    Member.find_each do |member|
      member.vcard.full_name = member.name
      member.save!
    end

    remove_column :members, :name
  end

  def down
    add_column :members, :name, :string

    Member.find_each do |member|
      member.name = member.vcard.full_name
      member.save!
    end
  end
end
