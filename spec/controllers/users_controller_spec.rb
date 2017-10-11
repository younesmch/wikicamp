require 'rails_helper'
require 'rolify'

RSpec.describe UsersController, type: :controller do

  let(:new_user_attributes) do
    {
      email: "wikicamp@wikicamp.com",
      password: "helloworld",
      password_confirmation: "blochead"
    }
  end

  describe "POST downgrade" do
    let(:factory_user) { create(:user)}

    before do
      @user.add_role :premium
    end

    it "removes premium role from user" do
      post :downgrade
      expect (@user.roles.include :premium).to be_false
    end

    it "redirects the user to root path" do
      post :downgrade
      expect(response).to redirect_to root_path
    end

  end

end
