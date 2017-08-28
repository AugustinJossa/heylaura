class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	return true
  end

  def manage_connection?
    if record == user
      return true
    else
      false
    end
  end

end
