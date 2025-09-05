# config/initializers/warden.rb
Rails.application.config.middleware.use Warden::Manager do |manager|
    manager.default_strategies :my_custom_strategy
    manager.failure_app = ->(env) { RegistrationsController.action(:new).call(env) }
  end
  