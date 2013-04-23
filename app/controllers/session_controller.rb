class SessionController < ApplicationController
  def create
  	if params[:session] && params[:session][:email]
  	  user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        respond_to do |format|
      	  format.json { render json: user }
        end
      else
        respond_to do |format|
      	  format.json { render json: default_error("login error"), status: 404}
        end
      end
    else
      respond_to do |format|
      	format.json { render json: default_error, status: 404 }
      end
    end
  end

  def destroy
  	sign_out
  	render json: {}
  end
end
