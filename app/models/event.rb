class Event < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :team
  has_many :ratings, dependent: :destroy

  validates_presence_of :summary, :start_at, :end_at

  def to_s
    summary
  end
end
