# frozen_string_literal: true

# abilty
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?

      if user.role == 'admin'
        can :manage, :all
        # can :read, User
      end

      can %i[create read], Slot, user: user if user.role == 'client'
    end
  end
end
