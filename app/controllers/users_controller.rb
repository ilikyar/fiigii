class UsersController < ApplicationController
=begin  
  before_filter :signed_in_user, 
                only: [ :update, :destroy, :following, :followers,
                 :friends_timeline, :timeline, :reset, :favourites]
  before_filter :correct_user,   only: [:update, :destroy, :friends_timeline, :reset]
=end
  # GET /users
  # GET /users.json
  def index
    @users = User.all(limit: 100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users.as_json(user: current_user) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user.as_json(user: current_user) }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user.as_json(user: current_user) }
    end
  end

  # GET /users/1/edit
  def edit 
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    puts params
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user.as_json(user: current_user), status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user.as_json(user: current_user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # GET /users/1/following.json
  def following
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
        @followed_users = @user.followed_users
        format.json { render json: @followed_users.as_json(user: current_user) }
      else
        format.json { render json: @user.errors }
      end
    end
  end

  #GET /users/1/followers.json
  def followers
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
        @followers = @user.followers
        format.json { render json: @followers.as_json(user: current_user) }
      else
        format.json { render json: @user.errors }
      end
    end
  end

  #GET /users/1/friends_timeline.json
  def friends_timeline
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
        @friends_timeline = @user.friends_timeline
        format.json { render json: @friends_timeline.as_json(user: current_user) }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /users/1/timeline.json
  def timeline
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
        @timeline = @user.timeline
        format.json { render json: @timeline.as_json(user: current_user) }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1/favourites.json
  def favourites
    @favourites = current_user.favourites
    respond_to do |format|
      format.json { render json: @favourites.as_json(user: current_user) }
    end
  end

  #GET /users/1/reset.json
  def reset
    @user = User.find(params[:id])
    respond_to do |format|
      if @user
        @user.update_attribute(:refresh_at, 1.weeks.ago)
        format.json { render json: @user.as_json(user: current_user) }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #GET /users/1/comments.json
  def comments
    @user = User.find(params[:id])
    @comments = @user.comments
    respond_to do |format|
      format.json { render json: @comments.as_json(user: current_user) }
    end
  end

end
