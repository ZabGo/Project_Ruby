require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
also_reload( '../models/*' )


get("/products")do
  @products = Product.all()
  erb(:products)
end

get("/new")do
  @type = Type.all()
  @manufacturer = Manufacturer.all()
  erb(:new)
end
post("/new")do
  @product = Product.new(params)
  @product.save()
  redirect to ("/")
end
