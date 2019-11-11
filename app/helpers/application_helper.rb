# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-danger',
      notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      classes = "alert #{bootstrap_class_for(msg_type)} fade in"
      concat(
        content_tag(:div, message, class: classes) do
          concat message
        end
      )
    end
    nil
  end
end
