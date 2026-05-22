class Adherent < ApplicationRecord
  has_many :cotations

  audited

  normalizes :nom_ville, with: ->(value) { value.upcase }
  normalizes :nom_contact, with: ->(value) { value.upcase }

  validates :nom_ville, :nom_contact, :email, presence: true

  def display_name
    "#{self.nom_ville} (#{self.nom_contact})"
  end

end
