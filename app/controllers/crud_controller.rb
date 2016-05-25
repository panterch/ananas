# CRUD Controller (inherited resources controller)
#
# This is the base for CRUD resources controller, only add code that really
# needs to be included in every inherited_resources controller.
class CrudController < InheritedResources::Base
  # Authorization
  load_and_authorize_resource

  # Responders
  respond_to :html, :js

  # Apply index pagination by default
  has_scope :page, default: 1, only: [ :index ]
  has_scope :per, default: Kaminari.config.default_per_page, only: [ :index ]

  # Search
  has_scope :by_text

  # check if this request was a search
  def by_text?
    params[:by_text].present?
  end
end

