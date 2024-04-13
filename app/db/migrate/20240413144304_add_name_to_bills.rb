class AddNameToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :name, :string
  end
end
