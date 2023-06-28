class ContributionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    user.is_a?(Author)
  end

  def new?
    create?
  end
end
