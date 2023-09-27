class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :story, null: true, foreign_key: true
      t.references :character, null: true, foreign_key: true
      t.integer :points

      t.timestamps
    end
  end
end
