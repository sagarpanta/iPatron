class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
 include Mobylette::RespondToMobileRequests
   
	mobylette_config do |config|
		config[:fall_back] = :html
		config[:skip_xhr_requests] = false
	end
end
