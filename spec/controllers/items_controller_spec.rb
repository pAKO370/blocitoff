require 'rails_helper'
include Pundit

describe ItemsController, type: :controller do

  let(:user1) {User.new(username: 'user1', email: 'user1@user.com', password: '12345678')}
  let(:user2) {User.new(username: 'user2', email: 'user2@user.com', password: '12345678')}

  before do
    user1.skip_confirmation!
    user1.save!
    user2.skip_confirmation!
    user2.save!
  end

  describe "user1 creates item" do
    before do 
      create_session(user1)
      it "creates item for user1" do
        post :create, user_id: user1.id, item: {name: "Test Item"}
        expect(Item.last.name).to eq("Test Item")
      end
      it "user2 creates item for user1" do
        post :create, user_id: user2.id, item: {name: "Test Item User2"}
        expect(Item.last.name).to eq("Test Item User2")
      end

    end
  end
end