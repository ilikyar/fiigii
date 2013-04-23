class StatusesController < ApplicationController
  before_filter :signed_in_user, 
                only: [:create, :update, :destroy]

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all(limit: 100)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses.as_json(user: current_user) }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status.as_json(user: current_user)}
    end
  end

  # GET /statuses/new
  # GET /statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status.as_json(user: current_user)}
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    json_data = params[:status]
    puts "\n\n\n#{json_data}\n\n\n"
    if json_data && json_data[:content]
      @status = Status.new(content: json_data[:content])
      if json_data[:topics]
        json_data[:topics].each do |topic|
          @status.topics << topic
        end
      end
      @status.retweeted_id = json_data[:retweeted_id]
      respond_to do |format|
        if @status.save
          current_user.statuses << @status
          format.html { redirect_to @status, notice: 'Status was successfully created.' }
          format.json { render json: @status.as_json(user: current_user), status: :created, location: @status }
        else
          format.html { render action: "new" }
          format.json { render json: @status.errors, status: :unprocessable_entity }
        end
      end
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end

  #GET /statuses/1/good.json
  def good
    @status = Status.find(params[:id])
    respond_to do |format|
      if @status
        @status.good!(current_user)
        format.json { render json: @status.as_json(user: current_user) }
      else
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /statuses/1/bad.json
  def bad
    @status = Status.find(params[:id])
    respond_to do |format|
      if @status
        @status.bad!(current_user)
        format.json { render json: @status.as_json(user: current_user) }
      else
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /statuses/1/comments.json
  def comments
    @status = Status.find(params[:id])
    @comments = @status.comments.limit(100)
    respond_to do |format|
      format.json { render json: @comments.as_json(user: current_user) }
    end
  end
end
