require( 'pry-byebug' )
require_relative( 'models/merchant' )

merchant2 = Merchant.new({ 'merchant_name' => 'Clarks'})
merchant2.save

Merchant.delete_all


# p Merchant.find('1')
