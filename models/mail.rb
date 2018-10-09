require("mail")

class Email

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

  def self.notification()
    Email.setup()

    mail = Mail.new do
      from    'guitarsclan.gmail.com'
      to      'xavier.godard@live.fr'
      subject 'test inside sinatra'
      body    'test content'
    end

    mail.deliver!
  end




end
