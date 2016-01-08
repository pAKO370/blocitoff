require 'rails_helper'
include Pundit

describe ItemsController, type: :controller do
  let(:user) {User.new(username: 'user1', email: 'user1@user.com', password: '12345678')}
  let(:other_user) {User.new(username: 'user2', email: 'user2@user.com', password: '12345678')}

  before do
    user.skip_confirmation!
    user.save!
    other_user.skip_confirmation!
    other_user.save!
  end

  describe "GET create" do
    context "when logged in as a user" do
      before do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
      end

      context "trying to create an item for that user" do
        it "creates an item for that user" do
          expect {
            post :create, user_id: user.id, item: {name: "Test Item"}
          }.to change(Item, :count).by(1)
        end

        it "create the item with the right attributes" do
          post :create, user_id: user.id, item: {name: "Test Item"}
          expect(Item.last.name).to eq("Test Item")
        end
      end

      context "trying to create an item for another user" do
        it "doesn't create an item for another user" do
          expect {
            post :create, user_id: other_user.id, item: {name: "Test Item User2"}
          }.to_not change(Item, :count)
        end
      end
    end
  end

  describe "DELETE #destroy_multiple" do
    let(:user_item_1) { user.items.create!(name: "an item") }
    let(:user_item_2) { user.items.create!(name: "an item") }
    let(:other_user_item) { other_user.items.create!(name: "an item") }

    context "when logged in as a user" do
      before do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in user
      end

      context "trying to destroy 2 items that belong to that user" do
        it "destroys both items" do
          expect {
            delete :destroy_multiple, user_id: user.id, item_ids: [user_item_1.id, user_item_2.id]
          }.to change(Item, :count).by(-2)
        end
      end

      context "trying to destroy 1 items that belongs to that user and 1 item that does not" do
        it "doesn't destroy anything" do
          expect {
            delete :destroy_multiple, user_id: user.id, item_ids: [user_item_1.id, other_user_item.id]
          }.to_not change(Item, :count)
        end
      end
    end
  end
end
