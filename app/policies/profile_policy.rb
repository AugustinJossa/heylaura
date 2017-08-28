class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def home?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def find_match?
    show?
  end

  def test?
    true
  end

  def manage_connection?
    if record.user == user
      return true
    else
      return false
    end
  end
end
