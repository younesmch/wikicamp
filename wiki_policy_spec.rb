require 'rails_helper'
describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  let(:user) { User.create!(email: "test@test.com", password: "helloworld") }
  let(:other_user) { User.create!(email: "test2@test.com", password: "helloworld") }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_actions(:show if wiki.public = true )}
    it { is_expected.to forbid_actions(:destroy, :create, :update, :new, :edit)}
  end

  context 'for free user, other public wiki' do
    let(:wiki) { FactoryGirl.create(:wiki, user: other_user) }

    it { is_expected.to permit_actions(:show, :new, :create, :edit, :update)
    it { is_expected.to forbid_action(:destroy)
  end

  context 'for free user, own public wiki' do
    let(:wiki) { FactoryGirl.create(:wiki, user: user) }

    it { is_expected.to permit_actions(:show, :new, :create, :edit, :update, :destroy)}
  end

  context 'being a premium user, other private wiki ' do
    let(:wiki) { FactoryGirl.create(:wiki, user: other_user) }

    it { is_expected.to permit_actions(:show, :create, :update, :new, :edit) }
    it { is_expected.to forbid_actions(:destroy)

  end

  context 'being a premium user, own private wiki ' do
    let(:wiki) { FactoryGirl.create(:wiki, user: user) }

    it { is_expected.to permit_actions(:show, :create, :update, :new, :edit, :destory) }

  end

  context 'being an admin allows you to edit other users wikis' do
    let(:wiki) { FactoryGirl.create(:wiki, user: other_user) }

    it { is_expected.to permit_actions(:show, :create, :update, :show, :new, :edit, :destroy) }

  end
end
