# helper for all controllers in the application
module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when :success
      'label label-success'
    when :error
      'label label-error'
    when :alert
      'label label-block'
    when :notice
      'label label-info'
    else
      flash_type.to_s
    end
  end
end
