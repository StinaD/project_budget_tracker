require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/merchant.rb' )
also_reload( '../models/*' )


get '/merchants' do
  @merchants = Merchant.all
  erb(:"merchants/show")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  Merchant.new(params).save
  redirect to '/merchants'
end

post '/merchants/:id/delete' do
  Merchant.delete(params[:id])
  redirect to ("/merchants")
end
