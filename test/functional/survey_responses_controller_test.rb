require 'test_helper'

class SurveyResponsesControllerTest < ActionController::TestCase
  setup do
    @survey_response = survey_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survey_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey_response" do
    assert_difference('SurveyResponse.count') do
      post :create, :survey_response => @survey_response.attributes
    end

    assert_redirected_to survey_response_path(assigns(:survey_response))
  end

  test "should show survey_response" do
    get :show, :id => @survey_response.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @survey_response.to_param
    assert_response :success
  end

  test "should update survey_response" do
    put :update, :id => @survey_response.to_param, :survey_response => @survey_response.attributes
    assert_redirected_to survey_response_path(assigns(:survey_response))
  end

  test "should destroy survey_response" do
    assert_difference('SurveyResponse.count', -1) do
      delete :destroy, :id => @survey_response.to_param
    end

    assert_redirected_to survey_responses_path
  end
end
