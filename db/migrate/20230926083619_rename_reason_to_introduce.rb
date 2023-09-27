class RenameReasonToIntroduce < ActiveRecord::Migration[7.0]
  def change
    rename_column :characters, :reason, :introduce
  end
end
