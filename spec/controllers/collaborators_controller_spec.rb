
RSpec.describe CollaboratorsController, type: :controller do
  let(:my_wiki) { create(:wiki) }
  let(:my_user) { create(:user) }
  let(:my_collaborator) { create(:user) }

  describe 'POST create' do

    it 'redirects to the edit wiki path view' do
      post :create, params: { collaborator: { user_id: my_user, wiki_id: my_wiki.id } }
      expect(response).to redirect_to(edit_wiki_path(id: my_wiki.id) )
    end

    it "assigns a collaborator to the current wiki" do
      post :create, params: { collaborator: { user_id: my_user, wiki_id: my_wiki.id } }
      expect(my_user.collaborators.find_by_id(my_wiki.id)).not_to be_nil
    end

  end

  describe 'DELETE destroy' do

    it 'redirects to the edit wiki path view' do
      my_collab = Collaborator.create(user_id: my_user.id, wiki_id: my_wiki.id)
      delete :destroy, params: { user_id: my_user, id: my_collab.id }
      expect(response).to redirect_to(edit_wiki_path(id: my_wiki.id) )
    end
  end

end
