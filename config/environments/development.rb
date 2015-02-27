Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Mailer info
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    enable_starttls_auto: false,
    address: ENV['MAILER_ADDRESS'],
    port: 587,
    domain: ENV['MAILER_DOMAIN'],
    authentication: :login,
    user_name: ENV['MAILER_USER'],
    password: ENV['MAILER_PASS']
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.sass.line_comments = true

  # Bullet
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = false
    Bullet.bullet_logger = true
    Bullet.console = true
  end

  # Paperclip
  Paperclip.options[:command_path] = "/usr/local/bin/"
end
