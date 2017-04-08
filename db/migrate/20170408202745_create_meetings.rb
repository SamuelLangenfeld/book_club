class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.date :date
      t.string :time
      t.references :book, foreign_key: true
      t.string :location

      t.timestamps
    end
  end
end
