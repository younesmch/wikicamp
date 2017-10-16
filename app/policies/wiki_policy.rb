class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    user == wiki.user || user.roles.include?(:admin)
  end

  def permitted_attributes
    [:title, :body]
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.has_role?(:admin) || user.has_role?(:premium)
        wikis = scope.all
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.user == user
            wikis << wiki
          end
        end
        wikis
      end
    end
  end


end
