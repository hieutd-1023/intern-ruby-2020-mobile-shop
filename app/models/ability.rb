class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can :manage, :all if user.admin_role?
  end
end
