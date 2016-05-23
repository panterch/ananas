class Mentor < ActiveRecord::Base
  def to_s
    job_title
  end
end
