require "application_system_test_case"

class DebtsTest < ApplicationSystemTestCase
  setup do
    @debt = debts(:one)
  end

  test "visiting the index" do
    visit debts_url
    assert_selector "h1", text: "Debts"
  end

  test "should create debt" do
    visit debts_url
    click_on "New debt"

    fill_in "Amount", with: @debt.amount
    fill_in "Due date", with: @debt.due_date
    fill_in "From user", with: @debt.from_user_id
    check "Paid" if @debt.paid
    fill_in "Payment", with: @debt.payment_id
    fill_in "To user", with: @debt.to_user_id
    click_on "Create Debt"

    assert_text "Debt was successfully created"
    click_on "Back"
  end

  test "should update Debt" do
    visit debt_url(@debt)
    click_on "Edit this debt", match: :first

    fill_in "Amount", with: @debt.amount
    fill_in "Due date", with: @debt.due_date
    fill_in "From user", with: @debt.from_user_id
    check "Paid" if @debt.paid
    fill_in "Payment", with: @debt.payment_id
    fill_in "To user", with: @debt.to_user_id
    click_on "Update Debt"

    assert_text "Debt was successfully updated"
    click_on "Back"
  end

  test "should destroy Debt" do
    visit debt_url(@debt)
    click_on "Destroy this debt", match: :first

    assert_text "Debt was successfully destroyed"
  end
end
