class ChangeMakerTypeFormatInNominations < ActiveRecord::Migration
  def change
    change_column :nominations, :maker_type, :string
  end

end
