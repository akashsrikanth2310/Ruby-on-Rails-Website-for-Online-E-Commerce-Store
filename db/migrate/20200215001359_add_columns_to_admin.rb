class AddColumnsToAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :name, :string
    add_column :admins, :phone_number, :string
    add_column :admins, :dob, :date
    add_column :admins, :address, :string
  end
end
