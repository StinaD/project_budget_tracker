require( 'pry-byebug' )
require_relative( 'models/merchant' )
require_relative( 'models/tag' )
require_relative( 'models/transaction' )

Transaction.delete_all
Merchant.delete_all
Tag.delete_all


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

transaction1 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 34.00,
  'transaction_date' => '2005-09-14',
  'tag_id' => tag1.id,
  'merchant_id' => merchant1.id
  })
transaction1.save

transaction2 = Transaction.new({
  'transaction_type' => "Purchase",
  'amount' => 40.00,
  'transaction_date' => '2005-12-25',
  'tag_id' => tag2.id,
  'merchant_id' => merchant2.id
  })
transaction2.save

transaction2.amount = 50.00
transaction2.update 


# binding.pry
# nil
