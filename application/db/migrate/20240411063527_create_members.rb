class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.float :height
      t.float :weight

      t.timestamps
    end
  end
end
