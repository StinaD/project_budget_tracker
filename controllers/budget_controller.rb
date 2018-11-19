require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/budget.rb' )
require_relative( '../models/transaction.rb' )
also_reload( '../models/*' )


get '/budget' do
  @budget = Budget.all
  @budget1 = @budget.first
  @transactions = @budget1.budget_transactions_sort_by_date_newest
  erb(:"budget/show")
end

get '/budget/sort' do
  @budget = Budget.all
  @budget1 = @budget.first
  @transactions = @budget1.transactions_sort_by(params['input'])
  erb(:"budget/show")
end

get '/budget/:id/edit' do
  @budget = Budget.find(params['id'])
  erb(:"budget/edit")
end

post '/budget/:id' do
  Budget.new(params).update
  redirect to '/budget'
end
