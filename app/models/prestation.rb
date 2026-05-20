class Prestation < ApplicationRecord
  audited
  
  validates :code, :libellé, :tarif, presence: true

  normalizes :code, with: ->(value) { value.upcase }
  normalizes :catégorie, with: ->(value) { value.upcase }
  normalizes :sous_catégorie, with: ->(value) { value.upcase }
  
  def display_name
    "#{ self.code } -> #{ self.libellé } = #{ self.tarif } € HT"
  end
end
