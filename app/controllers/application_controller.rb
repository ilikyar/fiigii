class ApplicationController < ActionController::Base
  include SessionHelper
  # protect_from_forgery

  def default_error(message="")
  	{
  		error: message
  	}
  end
end
