class AddProfileFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :craft, :string
    add_column :users, :learning_goals, :string
    add_column :users, :maker_crush, :string
  end
end
