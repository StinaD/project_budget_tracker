require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('controllers/merchants_controller')
require_relative('controllers/transactions_controller')
require_relative('controllers/wallet_controller')
also_reload('/models/*')


get '/' do
  erb( :index )
end
