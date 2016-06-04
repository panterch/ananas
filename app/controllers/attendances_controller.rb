class AttendancesController < ApplicationController
  authorize_resource
  respond_to :js, :html

  attr_accessor :parent
  helper_method :parent
  before_action do
    event_id = params[:event_id] || params[:mentoring_id]
    @parent = Event.find(event_id)
  end

  attr_accessor :resource
  helper_method :resource
  before_action do
    @resource = @parent.attendances.find(params[:id]) if params[:id]
  end

  def resource_class
    Attendance
  end
  helper_method :resource_class

  def create
    attendance_params = params[:attendance]

    result = Attendance.build_with_guest_ident(parent, attendance_params[:guest_ident])
    if result.is_a? Array
      result.each(&:save)
      self.resource = result.first
    else
      self.resource = result
      resource.save
    end
  end

  def attend
    resource.state = 'attending'
    resource.save
  end

  def decline
    resource.state = 'declined'
    resource.save
  end
end
