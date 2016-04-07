class ApplicationMailer < ActionMailer::Base
  default from: "banana <from@example.com>"
  layout 'mailer'
end
