require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
also_reload( '../models/*' )



get("/products")do
  @products = Product.all()
  @manufacturer = Manufacturer.all()
  @types = Type.all()
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
  redirect to ("/products")
end

# get("/search")do
# # @list = Manufacturer.all
#   erb(:search)
# end
#
# post("/search")do
#   input = params["search_input"]
#   redirect to("/search/#{input}")
# end

get("/search")do
  input = params[:search_input]
  @list = Manufacturer.by_name(input)
  erb(:search)
end

get("/search/product")do
  @manufacturer = Manufacturer.all()
  @types = Type.all()
  input = params[:search_input]
  @list = Product.by_name(input)
  erb(:search_product)
end

post("/products/manufacturers")do
  manufacturer_id = params["manufacturer_id"]
  redirect to ("/products/manufacturers/#{manufacturer_id}")
end

get("/products/manufacturers/:id")do
  @products = Product.by_manufacturer(params[:id])
  @manufacturer = Manufacturer.all()
  erb(:products)
end



get("/products/manufacturers/:id")do
  @products = Product.by_manufacturer(params[:id])
  @manufacturer = Manufacturer.all()
  erb(:products)
end









post("/products/types")do
  type_id = params["type"]
  redirect to ("/products/types/#{type_id}")
end

get("/products/types/:id")do
  @products = Product.by_type(params[:id])
  @types = Type.all()
  erb(:products)
end
#
# get("/products/manufacturers")do
#   @products = Product.by_manufacturer(params["manufacturer_id"])
#   @manufacturer = Manufacturer.all()
#   erb(:products)
# end


get("/:id/update")do
  @product = Product.find(params[:id])
  @type = Type.all()
  @manufacturer = Manufacturer.all()
  erb(:update)
end

post("/:id")do
  product = Product.new(params)
  product.update()
  redirect to("/products")
end



post("/:id/delete")do
  Product.delete(params[:id])
  redirect to ("/products")
end
