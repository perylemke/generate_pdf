class CreateSpendings < ActiveRecord::Migration[5.0]
  def change
    create_table :spendings do |t|
      t.decimal :value
      t.integer :section

      t.timestamps
    end
  end
end
