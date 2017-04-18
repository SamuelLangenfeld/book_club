require 'rails_helper'

RSpec.describe UsersController, type: :controller do

before(:all) do
  User.all.each do |user|
    user.destroy
  end
  @user=valid_user
  @second_user=second_user
end



  describe "GET #index" do
    context "when user not signed in" do
      it "redirects to root page" do
        get :index
        expect(response).to redirect_to("/")
      end
    end

    context "when user signed in" do
      it "renders user index page" do
        sign_in(@user)
        get :index
        expect(response).to be_success
      end

      it "returns a collection of all users" do
        sign_in(@user)
        get :index
        expect(assigns(:users)).to eq([@user, @second_user])
      end

    end
  end

  describe "GET #show" do

    context "when user not signed in" do
      it "redirects to root page" do
        get :show, params: {id:@user.id}
        expect(response).to redirect_to('/')
      end

    end

    context "when user signed in and tries to access wrong profile" do
      it "redirects to root page" do
        sign_in(@user)
        get :show, params: {id:@second_user.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user signed in and accesses own page" do
      it "shows the profile" do
        sign_in(@user)
        get :show, params: {id:@user.id}
        expect(response).to be_success
      end
    end
  end



end