class Rating < ActiveRecord::Base
  MAX_VOTE = 5

  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  validates :team, :event, :mentor, presence: true

  def self.vote_topics
    Rails.application.config_for(:ratings)['topics']
  end

  vote_topics.keys.each do |vote_topic|
    store_accessor :votes, vote_topic
    validates vote_topic, presence: true
  end

  def self.average_vote(ratings)
    ratings = Array(ratings)
    votes = ratings.map(&:votes)

    return if votes.empty?

    values = votes.map(&:values).flatten.map(&:to_i)
    average = values.sum / values.length.to_f

    # round to nearest 0.5
    (average * 2).round / 2.0
  end

  def average_vote
    self.class.average_vote(self)
  end
end
