class AddCostToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :cost, :decimal
  end
end
