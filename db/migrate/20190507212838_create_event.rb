class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events, force: true do |t|
      t.integer :amount, null: false
      t.datetime :date, null: false
      t.belongs_to :user_id, null: false, index: true

      t.datetime :created_at, null: false
    end
  end
end
