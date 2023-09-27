class RemovePersonId < ActiveRecord::Migration[7.0]
  def change
    remove_column :characters, :person_id, :integer
  end
end
