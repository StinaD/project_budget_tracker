require( 'pry-byebug' )
# require_relative( 'models/merchant' )
require_relative( 'models/tag' )

Merchant.delete_all
Tag.delete_all

merchant1 = Merchant.new({'merchant_name' => 'H&M'})
merchant1.save

tag1 = Tag.new({'tag_name' => 'Clothes'})
tag2 = Tag.new({'tag_name' => 'Groceries'})
tag3 = Tag.new({'tag_name' => 'Entertainment'})
tag4 = Tag.new({'tag_name' => 'Subscription'})
tag1.save
tag2.save
tag3.save
tag4.save

transaction1 = Transaction.new({
  'transcation_type' => "Purchase",
  'amount' => 34.00,
  'transaction_date' => 2005-09-14,
  'merchant1' => merchant1.id,
  'tag_id' => tag.id
  })
