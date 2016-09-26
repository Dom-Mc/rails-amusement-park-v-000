class AttractionPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all if user.present?
    end
  end

  def index?
    record && user
  end

  def create?
    record && user.try(:admin?)
  end

  def show?
    record && user
  end

  def update?
    record && user.try(:admin?)
  end

  def destroy?
    record && user.try(:admin?)
  end

end
