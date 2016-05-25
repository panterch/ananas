class Rating < ActiveRecord::Base
  belongs_to :team
  belongs_to :event
  belongs_to :mentor

  def self.vote_topics
    I18n.t('activerecord.attributes.rating.topic_enum').stringify_keys
  end
end
