class RenameStuffToSecret < ActiveRecord::Migration[7.0]
  def change
    rename_column :characters, :stuff, :secret
  end
end
