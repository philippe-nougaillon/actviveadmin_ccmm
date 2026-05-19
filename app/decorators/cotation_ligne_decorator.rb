class CotationLigneDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def prix_ht
    number_to_currency(model.prix_ht)    
  end

  def total_ht
    number_to_currency(model.total_ht)    
  end

end