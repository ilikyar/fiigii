module SessionHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in_user
    unless signed_in?
    	respond_to do |format|
    		format.json { render json: default_error("Plase Login") }
    		format.html { render json: default_error("Plase Login")}
    	end
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      respond_to do |format|
        format.json { render json: default_error("Place Login to #{@user.name}") }
      end
    end
  end
end
