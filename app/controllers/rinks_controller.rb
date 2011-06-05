


# RINKS CONTROLLER ======================
# TODO: make the rinks/index the landing page, once you login
# TODO: index shows map, where you select rink
# TODO: rinks/show either update div below with ajax or open a new tab with rink profile
# TODO: rinks/show add link to update your home rink
# TODO: rinks/show list all teams at that rink (& nearby rinks?), links to teams/show
# TODO: rinks/show list basic info, session info and stats
# TODO: rinks/show display comments allow users to make them
# TODO: set_rink_owner method & protect
# TODO: edit rink properties for rink owners only
# TODO: action: set_rink_contacted
# TODO: view: set_rink_contacted view



class RinksController < ApplicationController
  before_filter :authenticate_member!
  filter_access_to :edit, :attribute_check => true
  filter_access_to :update, :attribute_check => true
  filter_access_to :all

  #========================================
  #  Restful Actions
  #========================================
  # GET /rinks
  # GET /rinks.xml
  def index
    @rinks = Rink.all(
        :include => :address,
        :conditions => "addresses.latitude >= -90.00
                        and addresses.longitude >= -180.00
                        and visible = true")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rinks }
    end
  end

  # GET /rinks/1
  # GET /rinks/1.xml
  def show
    @rink = Rink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rink }
    end
  end

  # GET /rinks/new
  # GET /rinks/new.xml
  def new
    @rink = Rink.new
    @rink.address = Address.new

    respond_to do |format|
      format.html { render :controller => 'rinks', :action => "new" }
      format.xml  { render :xml => @rink }
    end
  end

  # GET /rinks/1/edit
  def edit
    @rink = Rink.find(params[:id], :include => :address)
    @rink.address = Address.new unless @rink.address
  end

  # POST /rinks
  # POST /rinks.xml
  def create
    @rink = Rink.new(params[:rink])

    @rink.owner_id = -1
    @rink.contact_id = -1

    respond_to do |format|
      if @rink.save
        format.html { redirect_to(@rink, :notice => 'Rink was successfully created.') }
        format.xml  { render :xml => @rink, :status => :created, :location => @rink }
      else
        format.html { render :controller => 'rinks', :action => "new" }
        format.xml  { render :xml => @rink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rinks/1
  # PUT /rinks/1.xml
  def update
    @rink = Rink.find(params[:id])

    respond_to do |format|
      if @rink.update_attributes(params[:rink])
        format.html { redirect_to(@rink, :notice => 'Rink was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rink.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rinks/1
  # DELETE /rinks/1.xml
  def destroy
    @rink = Rink.find(params[:id])
    @rink.destroy

    respond_to do |format|
      format.html { redirect_to(rinks_url) }
      format.xml  { head :ok }
    end
  end

  #========================================
  #  Search Actions
  #========================================
  def search

  end

  def auto_search

  end

  #========================================
  #  Maps Actions
  #========================================
  # GET /rinks
  # GET /rinks.xml
  def locate
    @rinks = Rink.all(
        :limit => 100,
        :include => :address,
        :conditions => "addresses.latitude >= -90.00
                        and addresses.longitude >= -180.00")
#        :conditions => "addresses.latitude >= -90.00
#                        and addresses.longitude >= -180.00
#                        and visible = 1")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rinks }
    end
  end

  # GET /rinks
  # GET /rinks.xml
  def locate_rinks
    @rinks = Rink.all(
        :include => :address,
        :conditions => "addresses.latitude >= -90.00
                        and addresses.longitude >= -180.00")
#        :conditions => "addresses.latitude >= -90.00
#                        and addresses.longitude >= -180.00
#                        and visible = 1")

    respond_to do |format|
      format.json { render :json => @rinks.as_json }
    end
  end

  # GET /rinks/info/1
  # GET /rinks/info/1.xml
  def info
    @rink = Rink.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false } # index.html.erb
      format.xml  { render :xml => @rinks }
    end
  end

  #========================================
  #  Other Actions
  #========================================
  def toggle_visible
    @rink = Rink.find(params[:id])
    @rink.visible = !@rink.visible

    @rink.save
#    respond_to do |format|
#      format.html { redirect_to(:back, :notice => 'Rink was successfully updated.') }
#    end

    # TODO: toggle_visible: return confirmation of success
  end

  def verify
    @rink = Rink.find(params[:id])

    @rink.verified = 1
    @rink.original_verified_date = DateTime.now if !(@rink.original_verified_date)
    @rink.last_verified_date = DateTime.now

    @rink.save
#    respond_to do |format|
#      format.html { redirect_to(:back, :notice => 'Rink was successfully updated.') }
#    end

    # TODO: verify: return confirmation of success
  end

  def unverify
    @rink = Rink.find(params[:id])

    @rink.verified = 0
    @rink.last_verified_date = DateTime.now

    @rink.save
#    respond_to do |format|
#      format.html { redirect_to(:back, :notice => 'Rink was successfully updated.') }
#    end

    # TODO: unverify: return confirmation of success
  end

  def set_contacted
    @rink = Rink.find(params[:id])

    @rink.contacted = 1
    @rink.original_contact_date = DateTime.now if !(@rink.original_contact_date)
    @rink.last_contact_date = DateTime.now

    @rink.save
#    respond_to do |format|
#      format.html { redirect_to(:back, :notice => 'Rink was successfully updated.') }
#    end

    # TODO: set_contacted: return confirmation of success
  end
end
