class AddRoleableToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :roleable, polymorphic: true, null: true, index: true
  end
end
