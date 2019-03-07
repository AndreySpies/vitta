class DoctorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    true
  end

  def index?
    true
  end

  def doctor?
    !user.doctor.nil?
  end

  def confirm_consultation?
    true
  end
end
