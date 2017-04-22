require 'rails_helper'

RSpec.describe MeetingsController, type: :controller do

  before(:all) do
    create_users
    @user=User.first
    @book = create_books
  end

  let(:valid_attributes){
    {book_id:Book.first.id, date:"4/4/1988", time:"12:24 am", location:"Xanadu"}
  }

  let(:change_attributes){
    {location:"somewhere else"}
  }

  after(:all) do
    clear_database
  end

  describe "GET #index" do
    it "returns an array of all meetings" do
      meeting=Meeting.create! valid_attributes
      get :index
      expect(assigns(:meetings)).to eq([meeting])
    end

    it "renders the meetings index page" do
      meeting=Meeting.create! valid_attributes
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested meeting to @meeting" do
      meeting=Meeting.create! valid_attributes
      get :show, params: {id: meeting.to_param}
      expect(assigns(:meeting)).to eq(meeting)
    end

    it "renders the meeting partial" do
      meeting=Meeting.create! valid_attributes
      get :show, params: {id: meeting.to_param}
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    context "user is not signed in" do
      it "redirects to sign in page" do
        get :new, params: {book_id: Book.first.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is signed in" do
      it "renders the new meeting page" do
        sign_in(@user)
        get :new, params: {book_id: Book.first.id}
        expect(response).to render_template(:new)
      end

      it "assigns a new meeting as @meeting" do
        sign_in(@user)
        get :new, params: {book_id: Book.first.id}
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end 
    end
  end

  describe "GET #edit" do
    context "user is not signed in" do
      it "redirects to login page" do
        meeting=Meeting.create! valid_attributes
        get :edit, params: {id: meeting.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is signed in" do
      it "renders the edit page for the meeting" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        get :edit, params: {id: meeting.id}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "POST #create" do
    context "user is not signed in" do
      it "redirects to login page" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end

      it "does not assign a new meeting to @meeting" do
        post :create, params: valid_attributes
        expect(assigns(:meeting).nil?)
      end
    end

    context "user is signed in" do
      it "creates a new meeting" do
        sign_in(@user)       
        expect{
          post :create, params: {meeting: valid_attributes}
        }.to change(Meeting, :count).by 1
      end

      it "redirects to the book's page" do
        sign_in(@user)
        post :create, params: {meeting: valid_attributes}
        expect(response).to redirect_to(Book.first)
      end
    end
  end

  describe "PUT #update" do
    context "user is not signed in" do
      it "redirects to login page" do
        meeting=Meeting.create! valid_attributes
        put :update, params: {id:meeting.id, meeting:change_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't update the meeting" do
        meeting=Meeting.create! valid_attributes
        put :update, params: {id:meeting.id, meeting: change_attributes}
        expect(Meeting.find(meeting.to_param).location).to eq(valid_attributes[:location])
      end
    end

    context "user is signed in" do
      it "updates the meeting" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        put :update, params: {id:meeting.to_param, meeting: change_attributes}
        expect(Meeting.find(meeting.to_param).location).to eq(change_attributes[:location])
      end

      it "redirects to the meeting's book page" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        put :update, params: {id:meeting.to_param, meeting: change_attributes}
        expect(response).to redirect_to(Book.find(meeting.book_id))
      end

      it "doesn't change the number of meetings" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        expect{
          put :update, params: {id:meeting.to_param, meeting: change_attributes}
        }.to_not change(Meeting, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    context "user is not signed in" do
      it "doesn't delete the meeting" do
        meeting=Meeting.create! valid_attributes
        expect{
          delete :destroy, params: {id:meeting.to_param}
        }.to_not change(Meeting, :count)
      end

      it "redirects to login page" do
        meeting=Meeting.create! valid_attributes
        delete :destroy, params: {id:meeting.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is signed in" do
      it "deletes the meeting" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        expect{
          delete :destroy, params: {id:meeting.to_param}
          }.to change(Meeting, :count).by -1
      end

      it "redirects to the meeting's book page" do
        sign_in(@user)
        meeting=Meeting.create! valid_attributes
        delete :destroy, params: {id:meeting.to_param}
        expect(response).to redirect_to(Book.find(meeting.book_id))
      end
    end
  end


end