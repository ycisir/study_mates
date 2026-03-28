class UserPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  def update?
    user.admin? || record == user
  end
end
