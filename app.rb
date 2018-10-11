require("sinatra")
require("pry")
require( 'sinatra/contrib/all')
require_relative('controllers/manufacturer_controller')
require_relative('controllers/product_controller')
require_relative('models/mail.rb')
also_reload("./models/*")

get("/")do
  erb(:index)
end
