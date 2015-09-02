class PagesController < ApplicationController
  def front
    redirect_to affirmations_path if logged_in?
  end
end