# Yields a block for each of our defined
# active record models
def each_active_record_model(&block)
  # eagerly require all the models in order to have them all available
  Dir["#{Rails.root}/app/models/**/*.rb"].each { |file| require file }

  ActiveRecord::Base
    .subclasses
    .reject { |type| type.to_s.include? '::' } # subclassed classes are not our own models
    .each(&block)
end

# Returns all `has_many` relations of the model, excluding
# the `has_many :through` ones.
def has_many_relations(model)
  model
    .reflect_on_all_associations(:has_many)
    .reject { |relation| relation.options[:through] }
end
