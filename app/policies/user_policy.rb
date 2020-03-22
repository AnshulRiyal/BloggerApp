class UserPolicy < ApplicationPolicy

  attr_reader :logged_in_user, :user_record

  def initialize(logged_in_user, user_record)
    @logged_in_user = logged_in_user
    @user_record = user_record
  end

  def index?
    admin?
  end

  def show?
    admin?
  end

  def edit?
    admin?
  end

  def update
    admin?
  end

  def admin?
    logged_in_user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
    
  end

end