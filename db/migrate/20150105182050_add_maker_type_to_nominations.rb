class AddMakerTypeToNominations < ActiveRecord::Migration
  def change
    add_column :nominations, :maker_type, :boolean
  end
end
