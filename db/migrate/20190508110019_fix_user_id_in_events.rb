class FixUserIdInEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :user_id_id, :user_id
  end
end
