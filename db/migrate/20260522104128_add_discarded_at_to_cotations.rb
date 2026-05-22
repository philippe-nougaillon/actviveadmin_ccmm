class AddDiscardedAtToCotations < ActiveRecord::Migration[8.1]
  def change
    add_column :cotations, :discarded_at, :datetime
    add_index :cotations, :discarded_at
  end
end
