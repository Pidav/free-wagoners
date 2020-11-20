class MissionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.coder.user == user
  end

  def accept?
    update?
  end

  def reject?
    update?
  end

end
