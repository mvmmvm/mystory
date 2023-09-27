class AddStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :stuff, :string
  end
end
