class PrestationDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def tarif
    number_to_currency(model.tarif)    
  end
  
end