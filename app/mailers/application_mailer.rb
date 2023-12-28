# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@olivine.com"
  layout "mailer"
end
