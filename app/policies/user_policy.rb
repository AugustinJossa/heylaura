class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
  	return true
  end

  def accepted?
  	return true
  end

end
