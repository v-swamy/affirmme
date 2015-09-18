class TwilioController < ApplicationController
  before_action :require_user_login

  def start
    message = TwilioWrapper::Messages.create(current_user, request.base_url)
    if message.successful?
      flash[:success] = "Your first affirmation has been sent successfully!"
      redirect_to affirmations_path
    else
      flash[:danger] = message.error_message
      redirect_to affirmations_path
    end
  end
end