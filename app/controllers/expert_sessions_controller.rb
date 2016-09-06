class ExpertSessionsController < EventsController

  defaults resource_class: ExpertSession
  belongs_to :mentor, optional: true
  custom_actions resource: :book

  def book
    resource.attendances.create(guest: current_user.profile, state: :invited)
    NotificationsMailer.booking_request(resource.mentor, current_user.profile, resource).deliver
  end

  def accept
    attendance = resource.attendances.find(params[:attendance_id])
    resource.accept_attendance(attendance)
    NotificationsMailer.booking_accepted_mentor(resource.mentor, attendance.guest, resource).deliver
    NotificationsMailer.booking_accepted_member(resource.mentor, attendance.guest, resource).deliver
  end

  def reject
    resource.reject_attendance(resource.attendances.find(params[:attendance_id]))
  end


  def expert_session_params
    permitted_params = params.require(:expert_session)

    permitted_params.permit([
      :summary,
      :description,
      :start_at,
      :end_at,
      :location,
      :url,
      :team_id,
      :mentor_id
    ])
  end
end
