class Authorspace::GroupPolicy < Authorspace::BasePolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.left_joins(:memberships).where(memberships: {author_id: author.id})
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    # record.authors.include?(author)
    true
  end

  def edit?
    update?
  end

  def destroy?
    record.authors.include?(author)
  end
end
