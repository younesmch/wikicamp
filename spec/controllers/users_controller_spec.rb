require 'rails_helper'
require 'rolify'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.add_role :premium
    sign_in @user
  end

  describe "POST downgrade" do

    it "removes premium role from user" do
      post :downgrade
      expect(@user.has_role? :premium).to be_falsey
    end

    it "redirects the user to root path" do
      post :downgrade
      expect(response).to redirect_to root_path
    end

  end

end
