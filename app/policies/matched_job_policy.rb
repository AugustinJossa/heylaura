class MatchedJobPolicy < ApplicationPolicy

    def show?
    	return true
    end

    def preparation?
    	return true
    end
  
     def update?
    	return true
    end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
