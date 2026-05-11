class Cotation < ApplicationRecord
  belongs_to :adherent
  has_many :cotation_lignes
  accepts_nested_attributes_for :cotation_lignes

  enum :statut, { 'créé': 0, 'envoyé': 1, 'validé': 2, 'refusé': 3, 'archivé': 4 }

end
