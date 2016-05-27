class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Mentor
    can :read, Event, mentor_id: nil, team_id: nil
    can :read, Team

    if user.admin?
      can :manage, :all
    else
      if user.mentor?
        mentor_id = user.profile_id

        can :manage, Mentor, id: mentor_id
        can :manage, Event, mentor_id: mentor_id
        can :manage, Team, team_mentors: { mentor_id: mentor_id }
        can :manage, Rating, mentor_id: mentor_id
      end

      if user.member?
        member_id = user.profile_id

        can :manage, Member, id: member_id
        can :manage, Event, team: { team_members: { member_id: member_id } }
        can :manage, Team, team_members: { member_id: member_id }
      end
    end
  end
end
