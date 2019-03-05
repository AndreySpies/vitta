class MedicalRecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def edit?
    true
  end

  def doctor_or_user?
    # record.user == user || is_doctor?
    record.user == user || !user.doctor.nil?
  end
end
