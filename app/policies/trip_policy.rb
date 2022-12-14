class TripPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    record.user_trips.where(creator: true).first.user.id == user.id
  end

  def board?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
