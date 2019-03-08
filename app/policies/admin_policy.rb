class AdminPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    update?
  end

  def update?
    !user.admin.nil?
  end
end
