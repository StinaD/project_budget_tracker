require( 'pry-byebug' )
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/wallet')


Merchant.delete_all
Tag.delete_all
Wallet.delete_all
Transaction.delete_all

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
  'amount' => 34.00,
  'transaction_date' => '2018-11-08',
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id,
  'wallet_id' => wallet1.id
  })
transaction1.save

transaction2 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 30.00,
  'transaction_date' => '2018-10-25',
  'merchant_id' => merchant2.id,
  'tag_id' => tag2.id,
  'wallet_id' => wallet1.id
  })
transaction2.save

transaction3 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 40.00,
  'transaction_date' => '2018-11-05',
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id,
  'wallet_id' => wallet1.id
  })
transaction3.save

p transaction3.tag_name
