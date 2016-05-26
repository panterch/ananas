class Rating < ActiveRecord::Base
  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  def self.vote_topics
    I18n.t('activerecord.attributes.rating.topic_enum').stringify_keys
  end

  vote_topics.keys.each do |vote_topic|
    store_accessor :votes, vote_topic
    validates vote_topic, presence: true
  end

  def average_vote
    average = votes.values.map(&:to_i).sum / votes.keys.length.to_f
    # round to nearest 0.5
    (average * 2).round / 2.0
  end
end
