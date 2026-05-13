class Adherent < ApplicationRecord
  has_many :cotations

  audited

  validates :nom_ville, :nom_contact, :email, presence: true

  def display_name
    "#{self.nom_ville} (#{self.nom_contact})"
  end
end
