class Article < ApplicationRecord
  def display_name
    "#{ self.code } -> #{ self.nom } = #{ self.prix_ht } € HT"
  end
end
