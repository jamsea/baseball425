require 'test_helper'

class BattingSeasonsControllerTest < ActionController::TestCase
  setup do
    @batting_season = batting_seasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batting_seasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batting_season" do
    assert_difference('BattingSeason.count') do
      post :create, batting_season: { ab: @batting_season.ab, ba: @batting_season.ba, bb: @batting_season.bb, bb_percent: @batting_season.bb_percent, cs: @batting_season.cs, doubles: @batting_season.doubles, gidp: @batting_season.gidp, gp: @batting_season.gp, hbp: @batting_season.hbp, hr: @batting_season.hr, ibb: @batting_season.ibb, jersey_number: @batting_season.jersey_number, k_percent: @batting_season.k_percent, obp: @batting_season.obp, ops: @batting_season.ops, pa: @batting_season.pa, position: @batting_season.position, r: @batting_season.r, rbi: @batting_season.rbi, sb: @batting_season.sb, season_order: @batting_season.season_order, sf: @batting_season.sf, sh: @batting_season.sh, singles: @batting_season.singles, slg: @batting_season.slg, so: @batting_season.so, tb: @batting_season.tb, team: @batting_season.team, triples: @batting_season.triples }
    end

    assert_redirected_to batting_season_path(assigns(:batting_season))
  end

  test "should show batting_season" do
    get :show, id: @batting_season
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @batting_season
    assert_response :success
  end

  test "should update batting_season" do
    put :update, id: @batting_season, batting_season: { ab: @batting_season.ab, ba: @batting_season.ba, bb: @batting_season.bb, bb_percent: @batting_season.bb_percent, cs: @batting_season.cs, doubles: @batting_season.doubles, gidp: @batting_season.gidp, gp: @batting_season.gp, hbp: @batting_season.hbp, hr: @batting_season.hr, ibb: @batting_season.ibb, jersey_number: @batting_season.jersey_number, k_percent: @batting_season.k_percent, obp: @batting_season.obp, ops: @batting_season.ops, pa: @batting_season.pa, position: @batting_season.position, r: @batting_season.r, rbi: @batting_season.rbi, sb: @batting_season.sb, season_order: @batting_season.season_order, sf: @batting_season.sf, sh: @batting_season.sh, singles: @batting_season.singles, slg: @batting_season.slg, so: @batting_season.so, tb: @batting_season.tb, team: @batting_season.team, triples: @batting_season.triples }
    assert_redirected_to batting_season_path(assigns(:batting_season))
  end

  test "should destroy batting_season" do
    assert_difference('BattingSeason.count', -1) do
      delete :destroy, id: @batting_season
    end

    assert_redirected_to batting_seasons_path
  end
end
