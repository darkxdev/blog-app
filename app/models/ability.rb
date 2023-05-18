# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id

    can :destroy, Post if user.role == 'admin'
    can :destroy, Comment if user.role == 'admin'
  end
end
