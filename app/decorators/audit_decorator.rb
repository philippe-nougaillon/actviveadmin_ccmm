class AuditDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all

  def audited_changes
    pp model.audited_changes    
  end

end