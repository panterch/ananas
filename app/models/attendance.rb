class Attendance < ActiveRecord::Base
  enum state: {
    invited: 0,
    attending: 1,
    declined: 2
  }

  belongs_to :event
  belongs_to :guest, polymorphic: true

  validates_presence_of :event, :guest

  def self.build_with_guest_ident(event, guest_ident)
    result = self.new(event: event)

    type, ident = guest_ident.split(':')
    # TODO: check on allowed types
    if type == 'Team'
      team = Team.find(ident)
      result = team.members.map do |member|
        self.new(event: event, guest: member)
      end
    else
      result.guest_type = type
      result.guest_id = ident
    end

    result
  end
end
