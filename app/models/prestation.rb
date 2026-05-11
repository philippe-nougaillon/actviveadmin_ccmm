class Prestation < ApplicationRecord
  def display_name
    "#{ self.code } -> #{ self.libellé } = #{ self.tarif } € HT"
  end
end
