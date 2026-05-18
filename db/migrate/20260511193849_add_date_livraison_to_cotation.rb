class AddDateLivraisonToCotation < ActiveRecord::Migration[8.1]
  def change
    add_column :cotations, :date_livraison_souhaitée, :date
  end
end
