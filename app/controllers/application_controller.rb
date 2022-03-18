# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def build_error_alert(err_messages)
    error_messages = err_messages.map { |msg| "<li>#{msg}</li>" }.join
    "<ul>#{error_messages}</ul>"
  end
end
