class AddPrestationReferencesToCotationLigne < ActiveRecord::Migration[8.1]
  def change
    add_reference :cotation_lignes, :prestation, null: false, foreign_key: true
    remove_column :cotation_lignes, :article_id
  end
end
