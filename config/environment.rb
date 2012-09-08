# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MobileCRM::Application.initialize!

Time::DATE_FORMATS[:default] = "%b %d %Y %H:%M%p"
