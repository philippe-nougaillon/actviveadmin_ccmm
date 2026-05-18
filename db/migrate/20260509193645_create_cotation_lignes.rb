class CreateCotationLignes < ActiveRecord::Migration[8.1]
  def change
    create_table :cotation_lignes do |t|
      t.references :cotation, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.string :intitulé
      t.integer :qté
      t.decimal :prix_ht, precision: 8, scale: 2

      t.timestamps
    end
  end
end
