class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.datetime :eventDate
      t.integer :priority

      t.timestamps
    end
  end
end
