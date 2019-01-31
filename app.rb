require( 'sinatra' )
require( 'sinatra/contrib/all' )if development?
require_relative('controllers/merchants_controller')
require_relative('controllers/budget_controller')
require_relative('controllers/transactions_controller')
also_reload('models/*')



get '/' do
  erb( :home )
end
