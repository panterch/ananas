class Rating < ActiveRecord::Base
  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  validate :all_voted

  def self.vote_topics
    I18n.t('activerecord.attributes.rating.topic_enum').stringify_keys
  end

  vote_topics.keys.each do |vote_topic|
    store_accessor :votes, vote_topic
  end

  def all_voted
    votes.each do |topic, rating|
      errors.add(topic, :blank) if rating.blank?
    end
  end
end
