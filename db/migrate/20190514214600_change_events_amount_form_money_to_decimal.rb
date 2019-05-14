class ChangeEventsAmountFormMoneyToDecimal < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :amount, :decimal, :precision => 8, :scale => 2
  end
end
