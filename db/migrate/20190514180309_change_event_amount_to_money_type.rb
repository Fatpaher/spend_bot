class ChangeEventAmountToMoneyType < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :amount, :money
  end
end
