class PatientRecordPolicy < ApplicationPolicy
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

  def edit?
    update?
  end

  def update?
    record.doctor.user == user
  end
end

def doctor_or_user?
    record.user == user || !user.doctor.nil?
  end
