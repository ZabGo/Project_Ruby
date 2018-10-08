require("sinatra")
require( 'sinatra/contrib/all')
require_relative('controllers/guitar_controller')
require_relative('controllers/manufacturer_controller')
require_relative('controllers/product_controller')
require_relative('controllers/filters_controller')

get("/")do
  erb(:index)
end
