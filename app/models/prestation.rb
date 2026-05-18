class Prestation < ApplicationRecord
  audited
  
  validates :code, :libellé, :tarif, presence: true

  def display_name
    "#{ self.code } -> #{ self.libellé } = #{ self.tarif } € HT"
  end
end
