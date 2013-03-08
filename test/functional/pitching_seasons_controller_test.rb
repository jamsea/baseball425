require 'test_helper'

class PitchingSeasonsControllerTest < ActionController::TestCase
  setup do
    @pitching_season = pitching_seasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pitching_seasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pitching_season" do
    assert_difference('PitchingSeason.count') do
      post :create, pitching_season: { babip: @pitching_season.babip, bb: @pitching_season.bb, bb_percent: @pitching_season.bb_percent, bk: @pitching_season.bk, bs: @pitching_season.bs, cg: @pitching_season.cg, er: @pitching_season.er, era: @pitching_season.era, gp: @pitching_season.gp, gs: @pitching_season.gs, h: @pitching_season.h, hbp: @pitching_season.hbp, hld: @pitching_season.hld, hr: @pitching_season.hr, ibb: @pitching_season.ibb, jersey_number: @pitching_season.jersey_number, k: @pitching_season.k, k_percent: @pitching_season.k_percent, l: @pitching_season.l, outs: @pitching_season.outs, outs: @pitching_season.outs, r: @pitching_season.r, season_order: @pitching_season.season_order, sho: @pitching_season.sho, sv: @pitching_season.sv, tbf: @pitching_season.tbf, team: @pitching_season.team, w: @pitching_season.w, whip: @pitching_season.whip, wp: @pitching_season.wp }
    end

    assert_redirected_to pitching_season_path(assigns(:pitching_season))
  end

  test "should show pitching_season" do
    get :show, id: @pitching_season
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pitching_season
    assert_response :success
  end

  test "should update pitching_season" do
    put :update, id: @pitching_season, pitching_season: { babip: @pitching_season.babip, bb: @pitching_season.bb, bb_percent: @pitching_season.bb_percent, bk: @pitching_season.bk, bs: @pitching_season.bs, cg: @pitching_season.cg, er: @pitching_season.er, era: @pitching_season.era, gp: @pitching_season.gp, gs: @pitching_season.gs, h: @pitching_season.h, hbp: @pitching_season.hbp, hld: @pitching_season.hld, hr: @pitching_season.hr, ibb: @pitching_season.ibb, jersey_number: @pitching_season.jersey_number, k: @pitching_season.k, k_percent: @pitching_season.k_percent, l: @pitching_season.l, outs: @pitching_season.outs, outs: @pitching_season.outs, r: @pitching_season.r, season_order: @pitching_season.season_order, sho: @pitching_season.sho, sv: @pitching_season.sv, tbf: @pitching_season.tbf, team: @pitching_season.team, w: @pitching_season.w, whip: @pitching_season.whip, wp: @pitching_season.wp }
    assert_redirected_to pitching_season_path(assigns(:pitching_season))
  end

  test "should destroy pitching_season" do
    assert_difference('PitchingSeason.count', -1) do
      delete :destroy, id: @pitching_season
    end

    assert_redirected_to pitching_seasons_path
  end
end
