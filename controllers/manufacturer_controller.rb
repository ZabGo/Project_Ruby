require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/product.rb")
require_relative("../models/manufacturer.rb")
require_relative("../models/types.rb")
require_relative("../models/mail.rb")
also_reload( '../models/*' )

############################################
#This route will show all the manufacturers#
############################################

get("/manufacturer")do
  @manufacturers = Manufacturer.all()
  erb(:"manufacturer/show")
end


######################################################
#These route will enable to create a new manufacturer#
######################################################

get("/manufacturer/new")do
  erb(:"manufacturer/new")
end

post("/manufacturer/new")do
  @manufacturer = Manufacturer.new(params)
  @manufacturer.save()
  redirect to("/manufacturer")
end


#######################################
#This route will delete a manufacturer#
#######################################

post("/manufacturer/:id/delete")do
  Manufacturer.delete(params[:id])
  redirect to("/manufacturer")
end


##################################################################
#These routes will update the update the detais of a manufacturer#
##################################################################

get("/manufacturer/:id/update")do
  @manufacturer = Manufacturer.find(params[:id])
  erb(:"manufacturer/update")
end

post("/manufacturer/:id")do
  manufacturer = Manufacturer.new(params)
  manufacturer.update()
  
  redirect to("/manufacturer")
end

##################################################################################
#This route will enable to get the details of a manufacturer and send an email to# them#
##################################################################################
get("/manufacturer/:id/details")do
  @manufacturer = Manufacturer.find(params[:id])
  erb(:"manufacturer/details")
end

post("/manufacturer/:id/details/request")do
  subject = params["subject"]
  body = params["request"]

  @manufacturer = Manufacturer.find(params[:id].to_i)
  Email.to_manufacturer(@manufacturer, subject, body)

  redirect to("/manufacturer")
end
