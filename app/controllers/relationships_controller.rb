class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  # POST /relationships
  # POST /relationships.json
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    respond_to do |format|
      format.json { render json: @user.as_json(current_user) }
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @user = User.find(params[:id])
    current_user.unfollow!(@user)

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
