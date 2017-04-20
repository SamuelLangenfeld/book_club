require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let(:valid_attributes) {
    {author_first_name: "Stephen", author_last_name:"King", title:"The Gunslinger"}
  }

  before(:all) do
    User.all.each do |user|
      user.destroy
    end
    @user=valid_user
    @second_user=second_user
  end

  render_views


  describe "GET #index" do
    it "renders the books index page" do
      get :index
      expect(response).to render_template('index')
    end

    it "returns a collection of all books" do
      book=Book.create! valid_attributes
      get :index
      expect(assigns(:books)).to eq([book])
    end
  end

  describe "GET #show" do
    it "assigns the requested book as @book" do
      book = Book.create! valid_attributes
      get :show, params: {id: book.to_param}
      expect(assigns(:book)).to eq(book)
    end

    context "user is signed in" do
      it "assigns the current user to @user" do
        sign_in(@user)
        book = Book.create! valid_attributes
        get :show, params: {id: book.to_param}
        expect(assigns(:user)).to eq(@user)
      end
    end

  end

  describe "GET #new" do
    context "user is not signed in" do
      it "redirects to login page and does not create @book" do
        get :new
        expect(assigns(:book)).to be nil
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is signed in" do
      it "assigns a new book as @book" do
        sign_in(@user)
        get :new
        expect(assigns(:book)).to be_a_new(Book)
      end
    end
  end

  describe "GET #edit" do
    context "user is not signed in" do
      it "redirects to login page" do
        book = Book.create! valid_attributes
        get :edit, params: {id: book.to_param}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is signed in" do
      it "renders the edit book page" do
        sign_in(@user)
        book = Book.create! valid_attributes
        get :edit, params: {id: book.to_param}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "POST #create" do
    context "user is not signed in" do
      it "redirects to login and does not create a book" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
        expect(assigns(:book)).to be nil
      end
    end

    context "user is signed in and passes valid params" do
      it "creates a book" do
        sign_in(@user)
        
        expect{
          post :create, params: {book:valid_attributes}
          }.to change(Book, :count).by 1
      end

      it "assigns a newly created book as @book" do
        sign_in(@user)
        post :create, params: {book: valid_attributes}
        expect(assigns(:book)).to be_a(Book)
        expect(assigns(:book)).to be_persisted
      end

      it "renders the book's show page" do
        sign_in(@user)
        post :create, params: {book:valid_attributes}
        expect(response).to redirect_to(Book.last)
      end
    end
  end


  describe "PUT #update" do
    context "user is not signed in" do
      let(:new_attributes){
        {title: "IT"}
      }

      it "redirects to login page" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}
        expect(response).to redirect_to(new_user_session_path)
      end

      it "doesn't change the book's attributes" do
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}
        expect(Book.find(book.to_param).title).to_not eq(new_attributes[:title])
      end
    end

    context "user is signed in and passes valid params" do

      let(:new_attributes){
        {title: "IT"}
      }

      it "renders the book's show page" do
        sign_in(@user)
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}
        expect(response).to redirect_to(book)
      end

      it "saves the new attributes" do
        sign_in(@user)
        book = Book.create! valid_attributes
        put :update, params: {id: book.to_param, book: new_attributes}
        expect(Book.find(book.to_param).title).to eq(new_attributes[:title])
      end

      it "doesn't change the number of Books" do
        sign_in(@user)
        book = Book.create! valid_attributes
        expect{
          
          put :update, params: {id: book.to_param, book: new_attributes}
        }.to_not change(Book, :count)
      end
    end

    describe "DELETE #destroy" do
      context "user is not signed in" do
        it "does not change the count of books" do
          book = Book.create! valid_attributes          
          expect{
            delete :destroy, params: {id:book.to_param}
            }.to_not change(Book, :count)
        end

        it "redirects to login page" do
          book = Book.create! valid_attributes
          delete :destroy, params: {id:book.to_param}
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      context "user is signed in" do
        it "deletes the book" do
          sign_in(@user)
          book = Book.create! valid_attributes
          delete :destroy, params: {id:book.to_param}
          expect(Book.count).to eq(0)
        end

        it "redirects user to books index page" do
          sign_in(@user)
          book = Book.create! valid_attributes
          delete :destroy, params: {id:book.to_param}
          expect(response).to redirect_to(books_path)
        end
      end
    end

  end
end