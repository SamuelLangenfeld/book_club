require 'rails_helper'

RSpec.describe NotesController, type: :controller do



  before(:all) do
    create_users
    @user=User.first
    @second_user=User.find(@user.id+1)
    @book = create_books 
  end

  after(:all) do
    clear_database
  end

  let(:valid_attributes){
    {content: "this is a note's content", book_id: Book.first.id, user_id: User.first.id}
  }

  let(:change_attributes){
    {content: "updated content", book_id: Book.first.id, user_id: User.first.id, id:Note.first.id}
  }

  describe 'POST #create' do
    context 'user is not signed in and book is not specified' do
      it "redirects to login page" do
        post :create, params: {note:valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't create the note" do
        post :create, params: {note:valid_attributes}
        expect(Note.all.empty?).to be true
      end

    end

    context 'user is signed in, book is not specified' do
      it "not save the note" do
        sign_in(@user)
        post :create, params: {note:{content:"some content", user_id:@user.id}}
        expect(Note.all.empty?).to be true
      end
    end

    context 'user is not signed in, book is specified' do
      it "raises an error" do
          post :create, params: {note: valid_attributes}
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'user is signed in, book is specified, no content in note' do
      it "does not save note" do
        sign_in(@user)
        post :create, params: {note: {user_id:@user.id, book_id:@book.id}}
        expect(Note.all.empty?).to be true
      end
    end

    context 'user is signed in, book specified, content is present' do
      it "saves a note to the database" do
        sign_in(@user)
        expect{
          post :create, params: {note:valid_attributes}
        }.to change(Note, :count).by 1
      end
    end
  end

  describe 'PUT #update' do
    context "user isn't signed in" do
      it "redirects to login page" do
        note=Note.create! valid_attributes
        put :update, params: {note: change_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't save changes" do
        note=Note.create! valid_attributes
        put :update, params: {note: change_attributes}
        expect(Note.first.content).to eq(valid_attributes[:content])
      end
    end

    context "user is signed in" do
      it "updates the note" do
        sign_in(@user)
        note=Note.create! valid_attributes
        put :update, params: {note: change_attributes}
        expect(Note.first.content).to eq(change_attributes[:content])
      end

      it "doesn't change the number of notes" do
        sign_in(@user)
        note=Note.create! valid_attributes
        expect{
          put :update, params: {note: change_attributes}
          }.to_not change(Note, :count)
      end
    end

    context "wrong user" do
      it "redirects to login page" do
        sign_in(@second_user)
        note=Note.create! valid_attributes
        put :update, params: {note: change_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't save changes" do
        sign_in(@second_user)
        note=Note.create! valid_attributes
        put :update, params: {note: change_attributes}
        expect(Note.first.content).to eq(valid_attributes[:content])
      end
    end
  end


  describe 'DELETE #destroy' do
    context "user is not the creator of the note" do
      it "redirects to login page" do
        sign_in(@second_user)
        note=Note.create! valid_attributes
        delete :destroy, params: {note: valid_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end
      it "doesn't delete the note" do
        sign_in(@second_user)
        note=Note.create! valid_attributes
        expect{
          delete :destroy, params: {note: valid_attributes}
          }.to_not change(Note, :count)
      end
    end

    context "user is the creator of the note" do
      it "deletes the note" do
        sign_in(@user)
        note=Note.create! valid_attributes
        expect{
          valid_attributes[:id]=Note.first.id
          delete :destroy, params: {note: valid_attributes}
          }.to change(Note, :count).by -1
      end
    end
  end




end