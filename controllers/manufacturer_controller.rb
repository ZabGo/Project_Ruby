require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
require_relative("../models/mail.rb")
also_reload( '../models/*' )


get("/manufacturer")do
  @manufacturers = Manufacturer.all()
  erb(:manufacturer)
end

get("/manufacturer/new")do
  erb(:manufacturer_new)
end

post("/manufacturer/new")do
  @manufacturer = Manufacturer.new(params)
  @manufacturer.save()
  redirect to("/manufacturer")
end

post("/manufacturer/:id/delete")do
  Manufacturer.delete(params[:id])
  redirect to("/manufacturer")
end

get("/manufacturer/:id/update")do
  @manufacturer = Manufacturer.find(params[:id])
  erb(:manufacturer_update)
end

post("/manufacturer/:id")do
  manufacturer = Manufacturer.new(params)
  manufacturer.update()
  redirect to("/manufacturer")
end

post("/manufacturer/:id/delete")do
  Manufacturer.delete(params[:id])
  redirect to("/manufacturer")
end

get("/manufacturer/:id/details")do
  @manufacturer = Manufacturer.find(params[:id])
  erb(:manufacturer_details)
end

post("/manufacturer/:id/details/request")do
  subject = params["subject"]
  body = params["request"]
  @manufacturer = Manufacturer.find(params[:id].to_i)
  Email.to_manufacturer(@manufacturer, subject, body)
  redirect to("/manufacturer")
end
