class Attendance < ActiveRecord::Base
  belongs_to :event
  belongs_to :guest, polymorphic: true

  enum state: {
    invited: 0,
    attending: 1,
    declined: 2
  }
end
