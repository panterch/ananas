module ApplicationHelper
  def guarded_paginate(collection)
    return unless collection.respond_to?(:total_pages)
    paginate(collection, remote: true)
  end
end
