require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
require_relative("../models/mail.rb")
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
  input_manufacturer = params[:search_manufacturer]
# binding.pry
  @list_manufacturer = Manufacturer.by_name(input_manufacturer)
  erb(:search)
end

get("/search/product")do
  input_product = params[:search_product]
  @list_products = Product.by_name(input_product)
  erb(:search_product)
end

post("/products/manufacturers")do
  manufacturer_id = params["manufacturer_id"]
  redirect to ("/products/manufacturers/#{manufacturer_id}")
end

get("/products/manufacturers/:id")do
  @products = Product.by_manufacturer(params[:id])
  @manufacturer = Manufacturer.all()
  @types = Type.all()
  erb(:products)
end



# get("/products/manufacturers/:id")do
#   @products = Product.by_manufacturer(params[:id])
#   @manufacturer = Manufacturer.all()
#   erb(:products)
# end

post("/products/types")do
  type_id = params["type"]
  redirect to ("/products/types/#{type_id}")
end

get("/products/types/:id")do
  @products = Product.by_type(params[:id])
  @types = Type.all()
  @manufacturer = Manufacturer.all()
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
  if product.quantity == 0
    Email.out_of_stock(product)
  elsif product.quantity < 5
    Email.low_stock(product)
  end

  redirect to("/products")
end



post("/:id/delete")do
  Product.delete(params[:id])
  redirect to ("/products")
end
