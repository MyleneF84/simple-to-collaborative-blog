class Authorspace::BasePolicy
  attr_reader :author, :record

  def initialize(author, record)
    @author = author
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def home
    false
  end

  class Scope
    def initialize(author, scope)
      @author = author
      # @scope = scope
      @scope = scope.is_a?(Array) ? scope.last : scope

    end

    def resolve
      # raise NotImplementedError, "You must define #resolve in #{self.class}"
      scope
    end

    private

    attr_reader :author, :scope
  end

end
