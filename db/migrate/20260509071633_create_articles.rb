class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :code
      t.string :nom
      t.text :description
      t.integer :prix_ht

      t.timestamps
    end
  end
end
