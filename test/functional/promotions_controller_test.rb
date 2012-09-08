require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  setup do
    @promotion = promotions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promotions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promotion" do
    assert_difference('Promotion.count') do
      post :create, promotion: { code: @promotion.code, description: @promotion.description, drawingtime: @promotion.drawingtime, endate: @promotion.endate, num_of_entries: @promotion.num_of_entries, playerid: @promotion.playerid, read: @promotion.read, startdate: @promotion.startdate }
    end

    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should show promotion" do
    get :show, id: @promotion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promotion
    assert_response :success
  end

  test "should update promotion" do
    put :update, id: @promotion, promotion: { code: @promotion.code, description: @promotion.description, drawingtime: @promotion.drawingtime, endate: @promotion.endate, num_of_entries: @promotion.num_of_entries, playerid: @promotion.playerid, read: @promotion.read, startdate: @promotion.startdate }
    assert_redirected_to promotion_path(assigns(:promotion))
  end

  test "should destroy promotion" do
    assert_difference('Promotion.count', -1) do
      delete :destroy, id: @promotion
    end

    assert_redirected_to promotions_path
  end
end
