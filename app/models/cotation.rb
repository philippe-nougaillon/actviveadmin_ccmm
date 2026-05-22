class Cotation < ApplicationRecord
  include Discard::Model
  
  belongs_to :adherent
  has_many :cotation_lignes

  audited

  accepts_nested_attributes_for :cotation_lignes
  has_associated_audits

  enum :statut, { 'créé': 0, 'envoyé': 1, 'validé': 2, 'refusé': 3, 'archivé': 4 }

  validates :ref, :intitulé, :statut, presence: true

  before_validation do 
    self.ref = "#{ Date.today.year }-#{ Cotation.where("updated_at like '#{ Date.today.year }%'").count + 1 }"  
  end
  
end
