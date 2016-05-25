require 'rails_helper'
require Rails.root.join('spec/support/active_record_helper')

RSpec.describe 'All ActiveRecord::Base models' do
  context 'has_many with :dependent key' do
    each_active_record_model do |model|
      has_many_relations(model).each do |has_many_relation|
        it "has :dependent defined on the #{model}##{has_many_relation.name} relation" do
          expect(has_many_relation.options[:dependent]).not_to be_nil
        end
      end
    end
  end
end
