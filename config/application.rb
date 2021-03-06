require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HotelManager
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.enabled = true
    config.assets.digest = true
    config.serve_static_assets = true
    config.exceptions_app = self.routes
    config.time_zone = 'Europe/Warsaw'
    config.active_record.default_timezone = :local # Or :utc
  end
end
