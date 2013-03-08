class PitchingSeasonsController < ApplicationController
  # GET /pitching_seasons
  # GET /pitching_seasons.json
  def index
    @pitching_seasons = PitchingSeason.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pitching_seasons }
    end
  end

  # GET /pitching_seasons/1
  # GET /pitching_seasons/1.json
  def show
    @pitching_season = PitchingSeason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pitching_season }
    end
  end

  # GET /pitching_seasons/new
  # GET /pitching_seasons/new.json
  def new
    @pitching_season = PitchingSeason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pitching_season }
    end
  end

  # GET /pitching_seasons/1/edit
  def edit
    @pitching_season = PitchingSeason.find(params[:id])
  end

  # POST /pitching_seasons
  # POST /pitching_seasons.json
  def create
    @pitching_season = PitchingSeason.new(params[:pitching_season])

    respond_to do |format|
      if @pitching_season.save
        format.html { redirect_to @pitching_season, notice: 'Pitching season was successfully created.' }
        format.json { render json: @pitching_season, status: :created, location: @pitching_season }
      else
        format.html { render action: "new" }
        format.json { render json: @pitching_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pitching_seasons/1
  # PUT /pitching_seasons/1.json
  def update
    @pitching_season = PitchingSeason.find(params[:id])

    respond_to do |format|
      if @pitching_season.update_attributes(params[:pitching_season])
        format.html { redirect_to @pitching_season, notice: 'Pitching season was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pitching_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitching_seasons/1
  # DELETE /pitching_seasons/1.json
  def destroy
    @pitching_season = PitchingSeason.find(params[:id])
    @pitching_season.destroy

    respond_to do |format|
      format.html { redirect_to pitching_seasons_url }
      format.json { head :no_content }
    end
  end
end
