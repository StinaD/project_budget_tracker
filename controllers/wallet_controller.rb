require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/wallet.rb' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )


get '/wallet' do
  @wallet = Wallet.all
  @wallet1 = @wallet.first
  @transactions = @wallet1.budget_transactions_sort_by_date_newest
  erb(:"wallet/show")
end

post '/wallet/sort' do
  @wallet = Wallet.all
  @wallet1 = @wallet.first
  @transactions = @wallet1.transactions_sort_by(params['input'])
  erb(:"wallet/show")
end

get '/wallet/:id/edit' do
  @wallet = Wallet.find(params['id'])
  erb(:"wallet/edit")
end

post '/wallet/:id' do
  Wallet.new(params).update
  redirect to '/wallet'
end
