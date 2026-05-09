class CotationLigne < ApplicationRecord
  belongs_to :cotation
  belongs_to :article
end
