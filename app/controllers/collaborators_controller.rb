class CollaboratorsController < ApplicationController

  def create
    user = User.find_by_id(params[:collaborator][:user_id])
    wiki = Wiki.find_by_id(params[:collaborator][:wiki_id])

    if Collaborator.create(user_id: user.id, wiki_id: wiki.id)
        flash[:notice] = "#{user.email} is now a collaborator"
      else
        flash[:alert] = "There was an error, #{user.email} was not added as a collaborator"
    end
      redirect_to edit_wiki_path(wiki)
  end

  def destroy
    collaborator = Collaborator.find_by_id(params[:id])

    if collaborator.destroy
      flash[:notice] = "Collaborator: #{collaborator.user.email} has been removed"
    else
      flash[:alert] = "Collaborator: #{collaborator.user.email} has not been removed"
    end
    redirect_to edit_wiki_path(collaborator.wiki)
  end

private
  def collaborator_params
    #id: nil, user_id: nil, wiki_id: nil, ???

  end
end
