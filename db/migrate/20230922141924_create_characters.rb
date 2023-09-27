class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.references :story, null: false, foreign_key: true
      t.integer :person_id
      t.string :name
      t.string :gender
      t.string :personality
      t.string :job
      t.string :reason
      t.string :stuff
      t.string :evidence, array: true
      t.boolean :is_criminal

      t.timestamps
    end
  end
end
