class AttendancesController < CrudController
  belongs_to :event, :mentoring, polymorphic: true, optional: true

  def attend
    resource.state = 'attending'
    resource.save
  end

  def decline
    resource.state = 'declined'
    resource.save
  end

  def attendance_params
    permitted_params = params.require(:attendance)

    permitted_params.permit([
      :guest_id,
      :guest_type
    ])
  end
end
