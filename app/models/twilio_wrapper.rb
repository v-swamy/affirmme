module TwilioWrapper
  class Messages
    attr_reader :message, :error_message
    def initialize(options={})
      @message = options[:message]
      @error_message = options[:error_message]
    end

    def self.create(user, url)
      client = Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"] 
      begin 
        message = client.account.messages.create({
          from: ENV["TWILIO_NUMBER"],
          to: user.phone,
          body: user.affirmations.first.text,
          status_callback: url + '/status'
        })
        new(message: message)
      rescue Twilio::REST::RequestError => e
        new(error_message: e.message)
      end
    end

    def successful?
      message.present?
    end
  end
end