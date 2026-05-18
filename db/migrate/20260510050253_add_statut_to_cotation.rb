class AddStatutToCotation < ActiveRecord::Migration[8.1]
  def change
    add_column :cotations, :statut, :integer, default: 0
  end
end
