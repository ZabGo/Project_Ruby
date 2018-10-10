require("mail")


class Email

  attr_reader :id, :product_id

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

  def self.notification(product)
    Email.setup()

    mail = Mail.new do
      from    'guitarsclan.gmail.com'
      to      'xavier.godard@live.fr'
      subject "Notification for item #{product.id}"
      body    "The stock for the item #{product.id} is low. Only #{product.quantity} in stock"
    end

    mail.deliver!
  end




end
