class CotationLigne < ApplicationRecord
  belongs_to :cotation
  belongs_to :article

  after_save :set_cotation_total_ht

private

  def set_cotation_total_ht
    #self.update(total_ht: self.cotation_lignes.sum(:total_ht))
    #self.cotation.total_ht = self.cotation.cotation_lignes.sum(:total_ht)
    self.cotation.update(total_ht: self.cotation.cotation_lignes.sum(:total_ht))
  end

end
