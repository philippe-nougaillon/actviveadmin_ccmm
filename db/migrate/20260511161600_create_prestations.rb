class CreatePrestations < ActiveRecord::Migration[8.1]
  def change
    create_table :prestations do |t|
      t.string :code
      t.string :libellé
      t.string :catégorie
      t.string :sous_catégorie
      t.string :description
      t.string :unité
      t.decimal :tarif, precision: 8, scale: 2
      t.string :compétence
      t.string :délai

      t.timestamps
    end
  end
end
