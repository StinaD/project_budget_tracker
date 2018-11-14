require("minitest/autorun")
require('date')
require_relative("../wallet")
require_relative("../merchant")
require_relative("../tag")
require_relative("../transaction")




class WalletTest < MiniTest::Test

  def setup
    @wallet1 = Wallet.new({
      'cash_balance' => 500.00,
      'budget_amount' => 200.00,
      'budget_start_date' => '2018-11-01',
      'budget_end_date' => '2018-11-30'
      })

    @wallet2 = Wallet.new({
      'cash_balance' => 500.00,
      'budget_amount' => 300.00,
      'budget_start_date' => '2018-11-01',
      'budget_end_date' => '2018-11-30'
      })

    @merchant1 = Merchant.new({'merchant_name' => 'H&M'})

    @tag1 = Tag.new({'tag_name' => 'Clothes'})

    @transaction1 = Transaction.new({
      'transaction_type' => "Purchase",
      'amount' => 30.00,
      'transaction_date' => '2018-11-19',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id,
      'wallet_id' => @wallet1.id
      })

    @transaction2 = Transaction.new({
      'transaction_type' => "Purchase",
      'amount' => 40.00,
      'transaction_date' => '2018-11-01',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id,
      'wallet_id' => @wallet1.id
      })

    @transaction3 = Transaction.new({
      'transaction_type' => "Purchase",
      'amount' => 30.00,
      'transaction_date' => '2018-12-06',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id,
      'wallet_id' => @wallet1.id
      })

    @transaction4 = Transaction.new({
      'transaction_type' => "Refund",
      'amount' => 30.00,
      'transaction_date' => '2018-12-06',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id,
      'wallet_id' => @wallet1.id
      })

    @transaction5 = Transaction.new({
      'transaction_type' => "Refund",
      'amount' => 40.00,
      'transaction_date' => '2018-11-30',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id,
      'wallet_id' => @wallet1.id
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
