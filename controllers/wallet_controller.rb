require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/wallet.rb' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )


get '/wallet' do
  @wallet = Wallet.all
  @wallet1 = @wallet.first
  @transactions = @wallet1.budget_transactions
  erb(:"wallet/show")
end

get
