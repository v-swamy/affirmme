class TwilioWorker
  include Sidekiq::Worker
  def perform(user_id)
    user = User.find_by(user_id: user_id)
    message = TwilioWrapper::Messages.create(user)
  end
end