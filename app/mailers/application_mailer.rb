# frozen_string_literal: true

# application{_controler}
class ApplicationMailer < ActionMailer::Base
  default from: 'bordiaharshal@gmail.com'
  layout 'mailer'
end
