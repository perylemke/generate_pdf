class AddSectionToSpendings < ActiveRecord::Migration[5.0]
  def change
    add_column :spendings, :section, :string
  end
end
