class Cotation < ApplicationRecord
  belongs_to :adherent
  has_many :cotation_lignes
  accepts_nested_attributes_for :cotation_lignes

  enum :statut, { 'créée': 0, 'envoyée': 1, 'validée': 2, 'refusée': 3, 'archivée': 4 }

end
