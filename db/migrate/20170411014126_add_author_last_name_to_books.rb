class AddAuthorLastNameToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :author_last_name, :string
  end
end
