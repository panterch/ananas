class Attendance < ActiveRecord::Base
  enum state: {
    invited: 0,
    attending: 1,
    declined: 2
  }

  belongs_to :event, inverse_of: :attendances
  belongs_to :guest, polymorphic: true

  validates_presence_of :event, :guest
end
