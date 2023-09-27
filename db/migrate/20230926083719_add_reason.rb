class AddReason < ActiveRecord::Migration[7.0]
  def change
    add_column :characters, :reason, :string
  end
end
