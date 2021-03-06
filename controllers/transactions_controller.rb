require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/merchant.rb' )
require_relative( '../models/tag.rb' )
require_relative( '../models/budget.rb' )
also_reload( '../models/*' )


get '/transactions' do
  @transactions = Transaction.all
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/show")
end

get '/transactions/sort' do
  @transactions = Transaction.sort_by(params['input'])
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/show")
end


get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  @budget = Budget.all
  erb(:"transactions/new")
end

post '/transactions' do
  Transaction.new(params).save
  redirect to '/transactions'
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params['id'])
  @merchants = Merchant.all
  @tags = Tag.all
  @budget = Budget.all
  erb(:"transactions/edit")
end

post '/transactions/:id' do
  Transaction.new(params).update
  redirect to '/transactions'
end
