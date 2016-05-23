class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end
    can :manage, Event
    can :manage, Team
    can :manage, Member
    can :manage, Mentor

    can [:show, :update], User, :id => user.id
  end
end
