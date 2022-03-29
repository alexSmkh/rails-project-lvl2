# frozen_string_literal: true

module ApplicationHelper
  def build_flash(content)
    return content.map { |msg| "<p class='mb-0'>#{msg}</p>" }.join if content.instance_of?(Array)

    "<p class='mb-0'>#{content}</p>"
  end
end
