class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.is_a?(Author)
  end

  def new?
    create?
  end

  def update?
    record.authors.include?(user)

    # false
  end

  def edit?
    update?
  end

  def destroy?
    record.authors.include?(user)
    # false
  end
end
