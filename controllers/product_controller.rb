require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
require_relative("../models/mail.rb")
also_reload( '../models/*' )

#######################
#show all the products#
#######################
get("/products")do
  @products = Product.all()
  @manufacturer = Manufacturer.all()
  @types = Type.all()
  erb(:"/product/show")
end
#end

######################
#Create a new product#
######################
get("/product/new")do
  @type = Type.all()
  @manufacturer = Manufacturer.all()
  erb(:"product/new")
end

post("/product/new")do
  @product = Product.new(params)
  @product.save()
  redirect to ("/products")
end
#end

############################
#text research by          #
# => name of manufacturer  #
# => name of product       #
# => description of product#
#########################
get("/search")do
  @input_product = params[:search_product]
  @input_description = params[:search_description]
  @input_manufacturer = params[:search_manufacturer]

  if @input_product == nil && @input_description == nil && @input_manufacturer != nil
    @list_manufacturer = Manufacturer.by_name(@input_manufacturer)
  elsif @input_product == nil && @input_manufacturer == nil && @input_description != nil
    @list_products = Product.by_description(@input_description)
  else
    @list_products = Product.by_name(@input_product)
  end

  erb(:search)
end
#end

###################################
#filters the results of product by#
# => manufacturer and / or        #
# => type of products             #
# => both                         #
###################################

#route to get the info from the page
post("/products/filters")do
  manufacturer_id = params["manufacturer_id"]
  type_id = params["type"]
  if manufacturer_id == "" and type_id != nil
    redirect to ("/products/types/#{type_id}")
  elsif manufacturer_id != nil and type_id == ""
    redirect to ("/products/manufacturers/#{manufacturer_id}")
  else
    redirect to ("/products/manufacturers/#{manufacturer_id}/types/#{type_id}")
  end
end

#filter by manufacturer
get("/products/manufacturers/:id")do
  @products = Product.by_manufacturer(params[:id])
  @manufacturer = Manufacturer.all()
  @types = Type.all()
  erb(:"/product/show")
end

#filter by type
get("/products/types/:id")do
  @products = Product.by_type(params[:id])
  @types = Type.all()
  @manufacturer = Manufacturer.all()
  erb(:"/product/show")
end

#filter by manufacturer and type
get("/products/manufacturers/:manufacturer_id/types/:type_id")do
  @products = Product.by_manufacturer_and_type(params[:manufacturer_id], params[:type_id])
  @types = Type.all()
  @manufacturer = Manufacturer.all()

  erb(:"/product/show")
end
#######
##end##
#######

##################
#Update a product#
##################

get("/product/:id/update")do
  @product = Product.find(params[:id])
  @type = Type.all()
  @manufacturer = Manufacturer.all()
  erb(:"product/update")
end

post("/product/:id")do
  product = Product.new(params)
  product.update()

  if product.quantity == 0
    Email.out_of_stock(product)
  elsif product.quantity < 5
    Email.low_stock(product)
  end

  redirect to("/products")
end
#end

##################
#Delete a product#
##################

post("/:id/delete")do
  Product.delete(params[:id])
  redirect to ("/products")
end
#end
