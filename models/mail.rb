require("mail")

class Email


##########
#set SMTP#
##########

  def self.setup
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                # :domain               => 'your.host.name',
                :user_name            => 'guitarsclan@gmail.com',
                :password             => 'code1clan2guitar',
                :authentication       => 'plain',
                :enable_starttls_auto => true
              }

      Mail.defaults do
        delivery_method :smtp, options
      end
  end


#######################################################
#send email to user when the stock of a product is low#
#######################################################

  def self.low_stock(product)
    Email.setup()

    mail = Mail.new do
      from    'guitarsclan.gmail.com'
      to      'xavier.godard@live.fr'
      subject "Notification for item #{product.id}"
      text_part do
        body 'This is plain text'
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p> The stock of the product #{product.name} is low.</p> <p>Please contact the manufacturer #{product.find_manufacturer.name} if you want to order more #{product.name}<a href='http://localhost:4567/manufacturer/#{product.manufacturer_id}/details'>Click here</a> </p>"
      end
    end

    mail.deliver!
  end


#################################################
#Send email to user when product is out of stock#
#################################################

  def self.out_of_stock(product)
    Email.setup()

    mail = Mail.new do
      from    'guitarsclan.gmail.com'
      to      'xavier.godard@live.fr'
      subject "Notification for item #{product.id}"
      text_part do
        body 'This is plain text'
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>The product #{product.name} is now out of stock. </p><p>Please contact the manufacturer #{product.find_manufacturer.name} to reorder the product  #{product.name} <a href='http://localhost:4567/manufacturer/#{product.manufacturer_id}/details'>Click here</a> </p>"
      end
    end

    mail.deliver!
  end


################################
#Send email to the manufacturer#
################################

  def self.to_manufacturer(manufacturer, subject1, body1)
    Email.setup()

    mail = Mail.new do
      from    'guitarsclan.gmail.com'
      to      "#{manufacturer.email}"
      subject subject1
      body body1
    end

    mail.deliver!
  end




end
