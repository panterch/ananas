class MembersController < CrudController
  belongs_to :team, optional: true

  def edit
    upcoming_sessions = resource.expert_sessions.upcoming
    @unconfirmed_expert_sessions = upcoming_sessions.merge(Attendance.invited)
    @accepted_expert_sessions = upcoming_sessions.merge(Attendance.attending)
    @declined_expert_sessions = upcoming_sessions.merge(Attendance.declined)
    edit!
  end

  def show
    upcoming_sessions = resource.expert_sessions.upcoming
    @unconfirmed_expert_sessions = upcoming_sessions.merge(Attendance.invited)
    @accepted_expert_sessions = upcoming_sessions.merge(Attendance.attending)
    @declined_expert_sessions = upcoming_sessions.merge(Attendance.declined)

    show!
  end

  def member_params
    permitted_params = params.require(:member)

    permitted_params.permit([
      :name,
      :description,
      :avatar,
      HasVcardSupport.permitted_params
    ])
  end
end
