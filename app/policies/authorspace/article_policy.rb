class Authorspace::ArticlePolicy < Authorspace::BasePolicy
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
    true
  end

  def new?
    create?
  end

  def update?
    record.authors.include?(author)
  end

  def edit?
    update?
  end

  def destroy?
    record.authors.include?(author)
  end
end
