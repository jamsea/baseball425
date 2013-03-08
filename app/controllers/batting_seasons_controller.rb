class BattingSeasonsController < ApplicationController
  # GET /batting_seasons
  # GET /batting_seasons.json
  def index
    @batting_seasons = BattingSeason.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @batting_seasons }
    end
  end

  # GET /batting_seasons/1
  # GET /batting_seasons/1.json
  def show
    @batting_season = BattingSeason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @batting_season }
    end
  end

  # GET /batting_seasons/new
  # GET /batting_seasons/new.json
  def new
    @batting_season = BattingSeason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @batting_season }
    end
  end

  # GET /batting_seasons/1/edit
  def edit
    @batting_season = BattingSeason.find(params[:id])
  end

  # POST /batting_seasons
  # POST /batting_seasons.json
  def create
    @batting_season = BattingSeason.new(params[:batting_season])

    respond_to do |format|
      if @batting_season.save
        format.html { redirect_to @batting_season, notice: 'Batting season was successfully created.' }
        format.json { render json: @batting_season, status: :created, location: @batting_season }
      else
        format.html { render action: "new" }
        format.json { render json: @batting_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /batting_seasons/1
  # PUT /batting_seasons/1.json
  def update
    @batting_season = BattingSeason.find(params[:id])

    respond_to do |format|
      if @batting_season.update_attributes(params[:batting_season])
        format.html { redirect_to @batting_season, notice: 'Batting season was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @batting_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /batting_seasons/1
  # DELETE /batting_seasons/1.json
  def destroy
    @batting_season = BattingSeason.find(params[:id])
    @batting_season.destroy

    respond_to do |format|
      format.html { redirect_to batting_seasons_url }
      format.json { head :no_content }
    end
  end
end
