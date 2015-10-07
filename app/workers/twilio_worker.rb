class TwilioWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(user_id, callback_url)
    user = User.find_by(id: user_id)
    url = callback_url
    message = TwilioWrapper::Messages.create(user, url)
  end
end