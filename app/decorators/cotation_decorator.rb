class CotationDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all
  decorates_association :cotation_lignes

  def total_ht
    number_to_currency(model.total_ht)    
  end

end