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
        can %i[read], Slot , user: user
        # can %i[read update], User , user: user



        # can :update, Notice, user: user
        # can :destroy, Notice, user: user
        # can :read, Notice, user: user
        # can :read, User
        # cannot :create, User
      end

  

    end
  end
end
