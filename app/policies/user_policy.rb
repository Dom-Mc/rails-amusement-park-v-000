class UserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.try(:admin?)
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    user.try(:admin?)
  end

  def create?
    record && (user.blank? || user.try(:admin?))
  end

  def show?
    record == user || user.try(:admin?)
  end

  def update?
    record == user || user.try(:admin?)
  end

  def destroy?
    record == user || user.try(:admin?)
  end

end
