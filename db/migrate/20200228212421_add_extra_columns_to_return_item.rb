class AddExtraColumnsToReturnItem < ActiveRecord::Migration[6.0]
  def change
    add_column :return_items, :user_name, :string
  end
end
