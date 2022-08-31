class ActivityPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    true
  end

  def edit?
    record.participations.where(creator: true).first.user_id == user.id
  end

  def update?
    record.participations.where(creator: true).first.user_id == user.id
  end

  def destroy?
    record.participations.where(creator: true).first.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
