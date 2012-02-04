class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    
    if user
      if user.admin?
        can :manage, :all
      else
        can :manage, Paste, :user_id => user.id
      end
    end
  end
end
