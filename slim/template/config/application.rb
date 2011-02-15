require File.expand_path('../boot', __FILE__)
require "action_controller/railtie"
Bundler.require(:default, Rails.env) if defined?(Bundler)

module <%= app_const_base %>
  # More options: http://guides.rubyonrails.org/configuring.html
  class Application < Rails::Application
    # config.time_zone = :local
    config.action_view.javascript_expansions[:defaults] = %w()
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    
    config.generators do |g|
      g.helper = false
      g.test_framework = false
    end
    
    config.secret_token = '<%= app_secret %>'
    config.cache_store :file_store
    config.session_store :cookie_store, :key => '_<%= app_name %>_session'
    
    config.whiny_nils = true
  end
end