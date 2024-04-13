class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.references :member, null: false, foreign_key: true
      t.date :date
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
