require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Bank
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.default_locale = 'pt-BR'

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
  end
end
