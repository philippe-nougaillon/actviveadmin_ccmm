class CotationLigne < ApplicationRecord
  belongs_to :cotation
  belongs_to :prestation

  audited associated_with: :cotation

  after_save :set_cotation_total_ht

  validates :qté, :prix_ht, presence: true

private

  def set_cotation_total_ht
    self.cotation.update(total_ht: self.cotation.cotation_lignes.sum(:total_ht))
  end

end
