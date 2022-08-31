class ActivityPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    record.user == current_user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
