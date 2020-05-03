class CreateReturns < ActiveRecord::Migration[6.0]
  def change
    create_table :returns do |t|
      t.belongs_to :user
      t.belongs_to :order
      t.timestamps
    end
  end
end
