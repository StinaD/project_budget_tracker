require("minitest/autorun")
require_relative("../transaction")
require_relative("../merchant")
require_relative("../tag")


class TransactionTest < MiniTest::Test

  def setup
    @merchant1 = Merchant.new({'merchant_name' => 'H&M'})
    @merchant2 = Merchant.new({'merchant_name' => 'Tesco'})
    @tag1 = Tag.new({'tag_name' => 'Clothes'})
    @tag2 = Tag.new({'tag_name' => 'Groceries'})
    @transaction1 = Transaction.new({
      'transaction_type' => "Purchase",
      'amount' => 34.00,
      'transaction_date' => '2005-09-14',
      'tag_id' => @tag1.id,
      'merchant_id' => @merchant1.id
      })
    @transaction2 = Transaction.new({
      'transaction_type' => "Purchase",
      'amount' => 40.00,
      'transaction_date' => '2005-12-25',
      'tag_id' => @tag2.id,
      'merchant_id' => @merchant2.id
      })
  end

  def test_total
    result = Transaction.total
    assert_equal(74.0, result)
  end



end
