class RoomPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin?
  end
end
