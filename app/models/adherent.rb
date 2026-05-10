class Adherent < ApplicationRecord
  has_many :cotations

  def display_name
    self.nom_ville + ' -> ' + self.nom_contact
  end
end
