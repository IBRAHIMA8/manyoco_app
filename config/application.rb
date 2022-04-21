require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ManyocoApp
  class Application < Rails::Application
    config.time_zone = 'GMT'
    config.active_record.default_timezone = :local
    I18n.available_locales = [:en, :fr]
    config.i18n.default_locale = :fr
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
  g.test_framework :rspec,
                   model_specs: true,
                   view_specs: false,
                   helper_specs: false,
                   routing_specs: false,
                   controller_specs: false,
                   request_specs: false
    end
  end
end
