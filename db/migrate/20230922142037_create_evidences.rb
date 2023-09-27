class CreateEvidences < ActiveRecord::Migration[7.0]
  def change
    create_table :evidences do |t|
      t.references :character, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
