require("sinatra")
require("pry")
require( 'sinatra/contrib/all')
require_relative('controllers/guitar_controller')
require_relative('controllers/manufacturer_controller')
require_relative('controllers/product_controller')
require_relative('models/mail.rb')

get("/")do
  erb(:index)
end
