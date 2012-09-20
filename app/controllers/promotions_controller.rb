class PromotionsController < ApplicationController
  # GET /promotions
  # GET /promotions.json
  def index
    @promotions = Promotion.order("created_at desc").find_all_by_playerid(params[:playerid])
	@bulbs = Notification.where('playerid = ?' , params[:playerid]).sum('bulb')
	
	@promotions.each do |promotion|
		promotion["total_bulbs"] = @bulbs
		promotion.save
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @promotions }
      format.xml { render xml: @promotions }
    end
  end

  # GET /promotions/1
  # GET /promotions/1.json
  def show
    @promotion = Promotion.find_all_by_id_and_playerid(params[:id], params[:playerid])[0]
	@promotion.read = 1
	@promotion.save
	
	@notification = Notification.find_all_by_notificationid_and_notification(@promotion.id, 'promotions')
	@notification[0].read = 1
	@notification[0].bulb = 0
	@notification[0].save
	
	@bulbs = Notification.where('playerid = ?' , params[:playerid]).sum('bulb')
	@promotion["total_bulbs"] = @bulbs
	@promotion.save


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/new
  # GET /promotions/new.json
  def new
    @promotion = Promotion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @promotion }
    end
  end

  # GET /promotions/1/edit
  def edit
    @promotion = Promotion.find(params[:id])
  end

  # POST /promotions
  # POST /promotions.json
  def create
    @promotion = Promotion.new(params[:promotion])

    respond_to do |format|
      if @promotion.save
		@promotion.update_notification
		@promotion.push
        format.html { redirect_to promotions_path(:playerid=>current_player.playerid), notice: 'Promotion was successfully created.' }
        format.json { render json: @promotion, status: :created, location: @promotion }
      else
        format.html { render action: "new" }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /promotions/1
  # PUT /promotions/1.json
  def update
    @promotion = Promotion.find(params[:id])

    respond_to do |format|
      if @promotion.update_attributes(params[:promotion])
        format.html { redirect_to @promotion, notice: 'Promotion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @promotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promotions/1
  # DELETE /promotions/1.json
  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy

    respond_to do |format|
      format.html { redirect_to promotions_url }
      format.json { head :no_content }
    end
  end
  

  
end
