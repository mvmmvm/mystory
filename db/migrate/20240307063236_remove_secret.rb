class RemoveSecret < ActiveRecord::Migration[7.0]
  def change
    remove_column :characters, :secret, :string
  end
end
