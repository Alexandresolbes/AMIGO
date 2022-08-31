class TripPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user_trips.where(creator: true).first.user.id == user.id
  end

  def destroy?
    record.user_trips.where(creator: true).first.user.id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
