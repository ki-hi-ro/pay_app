require "test_helper"

class DebtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @debt = debts(:one)
  end

  test "should get index" do
    get debts_url
    assert_response :success
  end

  test "should get new" do
    get new_debt_url
    assert_response :success
  end

  test "should create debt" do
    assert_difference("Debt.count") do
      post debts_url, params: { debt: { amount: @debt.amount, due_date: @debt.due_date, from_user_id: @debt.from_user_id, paid: @debt.paid, payment_id: @debt.payment_id, to_user_id: @debt.to_user_id } }
    end

    assert_redirected_to debt_url(Debt.last)
  end

  test "should show debt" do
    get debt_url(@debt)
    assert_response :success
  end

  test "should get edit" do
    get edit_debt_url(@debt)
    assert_response :success
  end

  test "should update debt" do
    patch debt_url(@debt), params: { debt: { amount: @debt.amount, due_date: @debt.due_date, from_user_id: @debt.from_user_id, paid: @debt.paid, payment_id: @debt.payment_id, to_user_id: @debt.to_user_id } }
    assert_redirected_to debt_url(@debt)
  end

  test "should destroy debt" do
    assert_difference("Debt.count", -1) do
      delete debt_url(@debt)
    end

    assert_redirected_to debts_url
  end
end
