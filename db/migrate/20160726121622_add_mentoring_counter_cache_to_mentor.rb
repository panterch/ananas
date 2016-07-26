class AddMentoringCounterCacheToMentor < ActiveRecord::Migration[5.0]
  def up
    add_column :mentors, :team_mentors_count, :integer, default: 0
    Mentor.pluck(:id).map do |mentor_id|
      Mentor.reset_counters(mentor_id, :team_mentors)
    end
  end

  def down
    remove_column :mentors, :team_mentors_count, :integer
  end
end
