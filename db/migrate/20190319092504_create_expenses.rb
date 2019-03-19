class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.text :description
      t.float :price
      t.boolean :cleared,  default: 0, null: false
      t.datetime :transaction_date
      t.timestamps
    end
  end
end
