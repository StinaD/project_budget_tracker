require( 'pry-byebug' )
require_relative( 'models/merchant' )
require_relative( 'models/tag' )
require_relative( 'models/transaction' )
require_relative( 'models/wallet' )


Transaction.delete_all
Merchant.delete_all
Tag.delete_all
Wallet.delete_all


merchant1 = Merchant.new({'merchant_name' => 'H&M'})
merchant1.save
merchant2 = Merchant.new({'merchant_name' => 'Tesco'})
merchant2.save

tag1 = Tag.new({'tag_name' => 'Clothes'})
tag2 = Tag.new({'tag_name' => 'Groceries'})
tag3 = Tag.new({'tag_name' => 'Entertainment'})
tag4 = Tag.new({'tag_name' => 'Subscription'})
tag1.save
tag2.save
tag3.save
tag4.save

wallet1 = Wallet.new({
  'cash_balance' => 500.00,
  'budget_amount' => 200.00,
  'budget_start_date' => '2018-11-01',
  'budget_end_date' => '2018-11-30'
  })
wallet1.save


transaction1 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 20.00,
  'transaction_date' => '2018-12-02',
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id,
  'wallet_id' => wallet1.id

  })
transaction1.save

transaction2 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 30.00,
  'transaction_date' => '2018-11-25',
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id,
  'wallet_id' => wallet1.id
  })
transaction2.save

transaction3 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 40.00,
  'transaction_date' => '2018-11-18',
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id,
  'wallet_id' => wallet1.id
  })
transaction3.save

# transaction2.amount = 50.00
# transaction2.update

# p Transaction.sort_by_date


# wallet2 = Wallet.new({
#   'cash_balance' => 1000.00,
#   'budget_amount' => 400.00,
#   'budget_start_date' => '2018-11-01',
#   'budget_end_date' => '2018-11-30'
#   })
# wallet2.save


wallet1.update_budget_amount(transaction3)
# binding.pry
# nil
# binding.pry
# nil
