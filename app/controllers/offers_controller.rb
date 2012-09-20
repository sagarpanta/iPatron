class OffersController < ApplicationController
  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.order("created_at desc").find_all_by_playerid(params[:playerid])
	@bulbs = Notification.where('playerid = ?' , params[:playerid]).sum('bulb')
	
	@offers.each do |offer|
		offer["total_bulbs"] = @bulbs
		offer.save
	end
		respond_to do |format|
		  format.html # index.html.erb
		  format.json { render json: @offers }
		  format.xml {render xml: @offers}
		end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find_all_by_id_and_playerid(params[:id], params[:playerid])[0]
	@offer.read = 1
	@offer.save

	@notification = Notification.find_all_by_notificationid_and_notification(@offer.id, 'offers')
	@notification[0].read = 1
	@notification[0].bulb = 0
	@notification[0].save
	

	@bulbs = Notification.where('playerid = ?' , params[:playerid]).sum('bulb')
	@offer["total_bulbs"] = @bulbs
	@offer.save
	

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
		@offer.update_notification
		@offer.push

        format.html { redirect_to offers_path(:playerid => current_player.playerid)}
		#offer_path(@offer, :playerid=> current_player.playerid), notice: 'Offer was successfully created.' }
        format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end
end