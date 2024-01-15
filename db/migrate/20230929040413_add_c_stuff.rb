class AddCStuff < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :c_stuff, :string
  end
end
