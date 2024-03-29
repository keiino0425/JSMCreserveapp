require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JSMCreserveapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # 日本語化の設定
    config.i18n.default_locale = :ja
    # タイムゾーンの変更（例)created_at カラムを取り出したときに日本時間に変換されるようになる）
    config.time_zone = 'Asia/Tokyo'
    initializer(:remove_action_mailbox_and_activestorage_routes, after: :add_routing_paths) { |app|
     app.routes_reloader.paths.delete_if {|path| path =~ /activestorage/}
     app.routes_reloader.paths.delete_if {|path| path =~ /actionmailbox/ }
    }
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end
