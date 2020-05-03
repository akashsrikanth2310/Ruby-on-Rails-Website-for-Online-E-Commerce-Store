class AddColumnsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :Name, :string
    add_column :users, :Phone_number, :string
    add_column :users, :dob, :date
    add_column :users, :address, :string
  end
end
