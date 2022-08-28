# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.role == "admin"
        can :manage, :all
        # can :read, User
      end

      if user.role == "client"
        can %i[create read], Slot, user: user
      end
    end
  end
end
