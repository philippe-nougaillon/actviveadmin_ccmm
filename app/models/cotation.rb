class Cotation < ApplicationRecord
  belongs_to :adherent
  has_many :cotation_lignes
  accepts_nested_attributes_for :cotation_lignes
end
