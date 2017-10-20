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
      if user.has_role?(:admin)
        wikis = scope.all
      elsif user.has_role?(:premium)
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if (wiki.private == false || wiki.user == user || wiki.collaborators.include?(Collaborator.find_by_user_id(user.id)))
            wikis << wiki
          end
        end
      else #free user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          #loop through all the wikis. Display wiki if public if they are a collaborator on a private wiki. Don't show if they created it since it should be public anyway
          if (wiki.private == false || wiki.collaborators.include?(Collaborator.find_by_user_id(user.id)))
            wikis << wiki
          end
        end
      end
      wikis #return the wikis array that has been built up
      end
    end
end
