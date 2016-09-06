class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Mentor
    can :read, Event, mentor_id: nil, team_id: nil
    can :read, Team
    can :read, Member
    can [:show, :update, :profile], User, id: user.id
    can [:attend, :decline], Attendance, guest: user.profile

    if user.admin?
      can :manage, :all
    else
      if user.mentor?
        mentor_id = user.profile_id

        can [:update, :edit, :show], Mentor, id: mentor_id
        can :manage, Event, mentor_id: mentor_id
        can [:show], Team, team_mentors: { mentor_id: mentor_id }
        can :manage, Rating, mentor_id: mentor_id
        cannot :create_attendance, ExpertSession
        can [:accept, :reject], ExpertSessionAttendance, guest_type: 'Member', event: { mentor_id: mentor_id }
        cannot [:book], ExpertSession
      end

      if user.member?
        member_id = user.profile_id

        can :manage, Member, id: member_id
        can :manage, Event, team: { team_members: { member_id: member_id } }
        can :manage, Team, team_members: { member_id: member_id }
        can :read, Rating, team: { team_members: { member_id: member_id } }

        # Explicit disallow ExpertSession management as it's a subclass of Event
        cannot :manage, ExpertSession
        can [:read, :book], ExpertSession
      end

      if user.team?
        profile_id = user.profile_id

        can :manage, Team, id: profile_id
        can :manage, Event, team_id: profile_id

        # Explicit disallow ExpertSession management as it's a subclass of Event
        cannot :manage, ExpertSession
      end
    end
  end
end
