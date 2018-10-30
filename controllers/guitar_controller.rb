require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
require_relative("../models/mail.rb")
require_relative("../models/guitar.rb")
also_reload( '../models/*' )



get("/guitars")do
  erb(:"guitar/show")
end

get("/guitars/show")do
  @guitars = Guitar.all()
  erb(:"guitar/show")
end

get("/guitars/new")do
@products = Product.all()
@manufacturer = Manufacturer.all()
@types = Type.all()
  erb(:"guitar/new")
end

post("/guitars/new")do
  @guitar = Guitar.new(params)
  @guitar.save()
  redirect to ("/guitars/new")
end

# post("/products/<%= product.id/guitar")do
#   @type = Type.all()
#
#
# end
