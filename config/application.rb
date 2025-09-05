require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "active_storage/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RibbonDiagram
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.cas_create_user = true
    config.before_configuration do
      aws_credentials = {
        # access_key_id: 'YOUR_ACCESS_KEY_ID',
        # secret_access_key: 'YOUR_SECRET_ACCESS_KEY',
        # region: 'us-east-1'
        # --------------
        # bucket: 'dv-work',
        # access_key_id: 'AKIAYS2NVX3YKJJKYBWQ',
        # secret_access_key: 'Yl8AVxKPKPQcIKWFOstCvDOruNJgcz/sTavUn4Tf',
        # s3_region: 'us-west-2',
      }
      config.x.aws_credentials = aws_credentials
    end

    config.rack_cas.server_url = "https://shib.idm.umd.edu/shibboleth-idp/profile/cas" # replace with your server URL
    config.rack_cas.service = "/users/registrations/new" # If your user model isn't called User, change this
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :utc  # Keep DB in UTC (recommended)
  end
end
