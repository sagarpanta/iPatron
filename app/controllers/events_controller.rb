class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.find_all_by_playerid(params[:playerid])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
	  format.xml {render xml: @events}
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find_all_by_id_and_playerid(params[:id], params[:playerid])
	@event[0].read = 1
	@event[0].save
	
	@notification = Notification.find_all_by_notificationid_and_notification(@event[0].id, 'events')
	@notification[0].read = 1
	@notification[0].save

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
		@event.update_notification
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  

  
end
