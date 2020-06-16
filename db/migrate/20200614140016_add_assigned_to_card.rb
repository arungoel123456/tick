class AddAssignedToCard < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :assigned, :boolean
  end
end
