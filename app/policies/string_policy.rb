class StringPolicy < ApplicationPolicy

  def home?
    true
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
