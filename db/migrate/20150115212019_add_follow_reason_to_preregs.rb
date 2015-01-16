class AddFollowReasonToPreregs < ActiveRecord::Migration
  def change
    add_column :preregs, :follow_reason, :string
  end
end
