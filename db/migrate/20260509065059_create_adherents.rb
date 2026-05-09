class CreateAdherents < ActiveRecord::Migration[8.1]
  def change
    create_table :adherents do |t|
      t.string :nom_ville
      t.string :nom_contact
      t.string :email
      t.text :memo

      t.timestamps
    end
  end
end
