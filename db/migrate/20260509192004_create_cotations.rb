class CreateCotations < ActiveRecord::Migration[8.1]
  def change
    create_table :cotations do |t|
      t.string :ref
      t.references :adherent, null: false, foreign_key: true
      t.string :intitulé
      t.text :mémo
      t.decimal :total_ht, precision: 8, scale: 2

      t.timestamps
    end
  end
end
