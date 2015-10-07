class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user_login, only: :start
  before_action :check_for_user_affirmations, only: :start

  def start
    current_user.set_next_affirmation_id
    message = TwilioWrapper::Messages.create(current_user, request.base_url)
    if message.successful?
      flash[:success] = "Your first affirmation has been sent successfully!"
      redirect_to affirmations_path
    else
      flash[:danger] = message.error_message
      redirect_to affirmations_path
    end
  end

  def status
    if params[:MessageStatus] == "delivered"
      message_phone = params[:To][2..-1]
      @user = User.find_by(phone: message_phone)
      @user.set_next_affirmation_id
      TwilioWorker.perform_in(5.minutes, @user.id, request.base_url)
    end
    render nothing: true
  end

  private

  def check_for_user_affirmations
    if current_user.affirmations.empty?
      flash[:danger] = "You do not have any affirmations!  Please enter an affirmation before starting."
      redirect_to affirmations_path
    end
  end
end