class AddConfession < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :confession, :string
  end
end
