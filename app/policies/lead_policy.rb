class LeadPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update_tweets?
    true
  end

  def destroy?
    true
  end
end
