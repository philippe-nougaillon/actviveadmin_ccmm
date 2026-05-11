class AddTotalHtToCotationLigne < ActiveRecord::Migration[8.1]
  def change
    add_column :cotation_lignes, :total_ht, :virtual, type: :integer, as: "prix_ht * qté", stored: true
  end
end
