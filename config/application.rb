require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module JavascriptStuff
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)


    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = [
    'third_party/jquery/jquery-1.6.1', 'third_party/jquery/jquery-tmpl/jquery.tmpl.js', 'third_party/jquery/jquery-tmpl/jquery.tmplPlus.js', 'third_party/jquery/jquery-ujs/src/rails.js', 'third_party/jquery/jquery-ui-1.8.11.custom.min',

    'third_party/flash_detection.js', 'third_party/yepnope.js', 'third_party/sproutcore-2.0.a.2.js',

	'hoo/setup_app.js',
    'hoo/browser_utilities.js', 'hoo/activeListenerDebugger.js',

    'hoo/infrastructure/simple-state-machine.js',
    "hoo/infrastructure/sm_configurations/abstractConfiguration.js", "hoo/infrastructure/sm_configurations/threeStateButtonStateMachine.js", "hoo/infrastructure/sm_configurations/fiveStateButtonStateMachine.js",

    "hoo/vector_math.js", "hoo/graphics.js",

    'widgets/widgets.js', 'hoo/widgets/buttons/three_state_item.js', 'widgets/buttons.js', 'widgets/headless_player.js',

	'hoo/widgets/flippy_toggle_thing.js',


	# order important here
    # coffeescripts
    'shorty', 'hoo/shit'
    ]

	# excanvas.js is included from window.haml because it has a conditional ie statement (that breaks in ie9 - fix) and i dont know how todo that here
	# modernizr.js is included in window because it has to load after excanvas

	#<link type="text/css" href="../stylesheets/Aristo/jquery-ui-1.8.7.custom.css" rel="stylesheet" />
    config.action_view.stylesheet_expansions = { :app => ['simple_reset', 'audioboo_theme', 'type', 'positioning', 'widget_specific'] } # 'Aristo/jquery-ui-1.8.7.custom'

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    ### Part of a Spork hack. See http://bit.ly/arY19y
    if Rails.env.test?
      initializer :after => :initialize_dependency_mechanism do
        # Work around initializer in railties/lib/rails/application/bootstrap.rb
        ActiveSupport::Dependencies.mechanism = :load
      end
    end

  end
end
