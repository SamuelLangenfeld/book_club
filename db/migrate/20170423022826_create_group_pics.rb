class CreateGroupPics < ActiveRecord::Migration[5.0]
  def change
    create_table :group_pics do |t|
      t.string :picture

      t.timestamps
    end
  end
end
