class Ability
  include CanCan::Ability

  def initialize(user)    
    if user.role == "admin"
      can :manage, :all
    else
      can :read, :all
      can :manage, Platform, id: user.platforms.map(&:id)
      can [:edit, :update], User, id: user.id
    end
  end
end
