class AddFromToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :from, :string
  end
end
