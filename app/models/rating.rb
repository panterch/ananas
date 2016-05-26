class Rating < ActiveRecord::Base
  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  validates :team, :event, :mentor, presence: true

  def self.vote_topics
    I18n.t('activerecord.attributes.rating.topic_enum').stringify_keys
  end

  vote_topics.keys.each do |vote_topic|
    store_accessor :votes, vote_topic
    validates vote_topic, presence: true
  end
end
