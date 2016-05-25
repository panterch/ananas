class Rating < ActiveRecord::Base
  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  validate :all_votes

  def self.vote_topics
    I18n.t('activerecord.attributes.rating.topic_enum').stringify_keys
  end

  def all_votes
    votes.to_h.each do |topic, vote|
      errors["votes.#{topic}"] << I18n.t('errors.messages.blank') if vote.blank?
    end
  end
end
