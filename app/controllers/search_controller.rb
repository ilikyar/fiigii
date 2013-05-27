class SearchController < ApplicationController
  def user_search
  	respond_to do |format|
  	  if params[:search] && params[:search][:name]
  	  	@users = User.where("name LIKE '%#{params[:search][:name]}%'")
  	  	format.json { render json: @users.as_json(user: current_user) }
  	  else
  		format.json { render json: @users.errors, status: :unprocessable_entity }
  	  end
  	end
  end

  def status_search
  	respond_to do |format|
  	  if params[:search] && params[:search][:content]
  	  	@statuses = Status.where("content LIKE '%#{params[:search][:name]}%'")
  	  	format.json { render json: @statuses.as_json(user: current_user) }
  	  else
  		format.json { render json: @statuses.errors, status: :unprocessable_entity }
  	  end
  	end
  end
end
