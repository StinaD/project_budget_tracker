require( 'pry-byebug' )
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')
require_relative('../models/wallet')


Merchant.delete_all
Tag.delete_all
Wallet.delete_all
Transaction.delete_all

merchant1 = Merchant.new({'merchant_name' => 'Prada'})
merchant1.save
merchant2 = Merchant.new({'merchant_name' => 'Waitrose'})
merchant2.save
merchant3 = Merchant.new({'merchant_name' => 'Waterstones'})
merchant3.save
merchant4 = Merchant.new({'merchant_name' => 'Odeon Cinemas'})
merchant4.save
merchant5 = Merchant.new({'merchant_name' => "Laings"})
merchant5.save
merchant6 = Merchant.new({'merchant_name' => "Harrods"})
merchant6.save
merchant7 = Merchant.new({'merchant_name' => "The Ritz"})
merchant7.save
merchant8 = Merchant.new({'merchant_name' => "British Airways"})
merchant8.save


tag1 = Tag.new({'tag_name' => 'Clothes'})
tag2 = Tag.new({'tag_name' => 'Handbags and accessories'})
tag3 = Tag.new({'tag_name' => 'Groceries'})
tag4 = Tag.new({'tag_name' => 'Entertainment'})
tag5 = Tag.new({'tag_name' => 'Dining out'})
tag6 = Tag.new({'tag_name' => 'Subscription'})
tag7 = Tag.new({'tag_name' => 'Personal care'})
tag8 = Tag.new({'tag_name' => 'Travel'})
tag1.save
tag2.save
tag3.save
tag4.save
tag5.save
tag6.save
tag7.save
tag8.save

wallet1 = Wallet.new({
  'wallet_name' => "Your budget",
  'budget_amount' => 200.00,
  'budget_start_date' => '2018-11-01',
  'budget_end_date' => '2018-11-30'
  })
wallet1.save

transaction1 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 70.00,
  'transaction_date' => '2018-11-08',
  'merchant_id' => merchant1.id,
  'tag_id' => tag1.id,
  'wallet_id' => wallet1.id
  })
transaction1.save

transaction2 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 50.00,
  'transaction_date' => '2018-10-25',
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id,
  'wallet_id' => wallet1.id
  })
transaction2.save

transaction3 = Transaction.new({
  'transaction_type' => "Refund",
  'amount' => 30.00,
  'transaction_date' => '2018-11-05',
  'merchant_id' => merchant2.id,
  'tag_id' => tag3.id,
  'wallet_id' => wallet1.id
  })
transaction3.save

transaction4 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 150.00,
  'transaction_date' => '2018-11-06',
  'merchant_id' => merchant5.id,
  'tag_id' => tag2.id,
  'wallet_id' => wallet1.id
  })
transaction4.save


transaction5 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 150.00,
  'transaction_date' => '2018-11-02',
  'merchant_id' => merchant7.id,
  'tag_id' => tag5.id,
  'wallet_id' => wallet1.id
  })
transaction5.save

transaction6 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 20.00,
  'transaction_date' => '2018-10-15',
  'merchant_id' => merchant3.id,
  'tag_id' => tag4.id,
  'wallet_id' => wallet1.id
  })
transaction6.save

transaction7 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 20.00,
  'transaction_date' => '2018-10-21',
  'merchant_id' => merchant4.id,
  'tag_id' => tag4.id,
  'wallet_id' => wallet1.id
  })
transaction7.save

transaction8 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 410.00,
  'transaction_date' => '2018-10-29',
  'merchant_id' => merchant8.id,
  'tag_id' => tag8.id,
  'wallet_id' => wallet1.id
  })
transaction7.save
