require 'test_helper'

class SpendingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @spending = spendings(:one)
  end

  test "should get index" do
    get spendings_url
    assert_response :success
  end

  test "should get new" do
    get new_spending_url
    assert_response :success
  end

  test "should create spending" do
    assert_difference('Spending.count') do
      post spendings_url, params: { spending: { section: @spending.section, value: @spending.value } }
    end

    assert_redirected_to spending_url(Spending.last)
  end

  test "should show spending" do
    get spending_url(@spending)
    assert_response :success
  end

  test "should get edit" do
    get edit_spending_url(@spending)
    assert_response :success
  end

  test "should update spending" do
    patch spending_url(@spending), params: { spending: { section: @spending.section, value: @spending.value } }
    assert_redirected_to spending_url(@spending)
  end

  test "should destroy spending" do
    assert_difference('Spending.count', -1) do
      delete spending_url(@spending)
    end

    assert_redirected_to spendings_url
  end
end
