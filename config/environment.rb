# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  enable_starttls_auto: false,
  address: ENV['MAILER_ADDRESS'],
  port: 587,
  domain: ENV['MAILER_DOMAIN'],
  authentication: :login,
  user_name: ENV['MAILER_USER'],
  password: ENV['MAILER_PASS']
}
