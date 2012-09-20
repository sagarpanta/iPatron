class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.find_all_by_playerid(params[:playerid])
	
	@notifications.each do |notification|
		notification.bulb = 0
		notification.save
	
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifications }
      format.xml { render xml: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find_all_by_id_and_playerid(params[:id], params[:playerid])[0]
	@notification.read = 1
	@notification.bulb = 0
	@notification.save
	
	if @notification.notification == 'offers'
		@offer = Offer.find_by_id(@notification.notificationid)
		@offer.read = 1
		@offer.save
	elsif @notification.notification == 'events'
		@event = Event.find_by_id(@notification.notificationid)
		@event.read = 1
		@event.save
	elsif @notification.notification == 'promotions'
		@promotion = Promotion.find_by_id(@notification.notificationid)
		@promotion.read = 1
		@promotion.save
	end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end
end
