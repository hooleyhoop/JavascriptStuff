# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
JavascriptStuff::Application.initialize!

Haml::Template.options[:format] = :html5
Haml::Template.options[:ugly] = true
