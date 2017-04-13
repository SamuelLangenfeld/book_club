module BooksHelper
  def get_view_for_user_type
    if user_signed_in?
      @user=current_user
      'registered_user'
    else
      'unregistered_user'
    end
  end

  def get_author_full_name(book)
    book.author_first_name+" "+book.author_last_name
  end
end
