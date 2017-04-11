class AddAuthorFirstNameToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :author_first_name, :string
  end
end
