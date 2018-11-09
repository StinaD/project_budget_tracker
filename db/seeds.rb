require( 'pry-byebug' )

merchant1 = Merchant.new({
  'merchant_name' => "H&M"
  })

tag1 = Tag.new({
  'tag_name' => "Clothes"
  })


transaction1 = Transaction.new({
  'transcation_type' => "Purchase",
  'amount' => 34.00,
  'transaction_date' => 2005-09-14,
  'merchant1' => merchant1.id,
  'tag_id' => tag.id
  })
