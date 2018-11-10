require("minitest/autorun")
require('date')
require_relative("../wallet")




class WalletTest < MiniTest::Test

  def setup
    @wallet1 = Wallet.new({
      'cash_balance' => 500.00,
      'budget_amount' => 200.00,
      'budget_start_date' => '2018-11-01',
      'budget_end_date' => '2018-11-30'
      })
  end

  def test_days_spent()
    start_date = Date.parse(@wallet1.budget_start_date)
    today = Date.today
    expected = today - start_date
    expected.to_i
    assert_equal(expected, @wallet1.number_of_days_spent)
  end

  def test_days_remaining
    end_date = Date.parse(@wallet1.budget_end_date)
    today = Date.today
    expected = (end_date - today).to_i
    assert_equal(expected, @wallet1.number_of_days_remaining)
  end

  def test_total_budget_days
    start_date = Date.parse(@wallet1.budget_start_date)
    end_date = Date.parse(@wallet1.budget_end_date)
    expected = (end_date - start_date).to_i
    assert_equal(expected, @wallet1.number_of_days_in_budget)
  end



end
