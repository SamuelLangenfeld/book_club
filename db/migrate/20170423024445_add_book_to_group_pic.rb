class AddBookToGroupPic < ActiveRecord::Migration[5.0]
  def change
    add_reference :group_pics, :book, foreign_key: true
  end
end
