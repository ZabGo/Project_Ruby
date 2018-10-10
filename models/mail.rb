require("mail")


class Email

  attr_accessor :product_id
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i
    @product_id = options["product_id"].to_i
  end

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


  def save()
    sql = "
    INSERT INTO notifications (product_id)
    VALUES ($1)
    RETURNING id
    "
    values = [@product_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM notifications"
    results = SqlRunner.run(sql)
    notifications = results.map{|email| Email.new(email)}
    return notifications
  end

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
        body "<p> The stock of the product #{product.name} is low.</p> <p>Contact the manufacturer #{product.manufacturer.name} to order more #{product.name}<a href='http://localhost:4567/manufacturer/#{product.manufacturer_id}/details'>Click here</a> </p>"
      end
    end

    mail.deliver!
  end

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
        body "<p>Contact the manufacturer #{product.manufacturer.name} to order more #{product.name} the product #{product.id} <a href='http://localhost:4567/manufacturer/#{product.manufacturer_id}/details'>Click here</a> </p>"
      end
    end

    mail.deliver!
  end

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
