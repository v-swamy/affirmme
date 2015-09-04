class AffirmationsController < ApplicationController
  before_action :require_user_login
  before_action :set_affirmation, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @affirmations = current_user.affirmations
  end

  def new
    @affirmation = Affirmation.new
  end

  def create
    @affirmation = Affirmation.new(affirmation_params)
    @affirmation.user = current_user
    if @affirmation.save
      flash[:success] = "Your affirmation has been added!"
      redirect_to affirmations_path
    else
      render 'new'
    end
  end

  def edit
    @affirmation = Affirmation.find(params[:id])
  end

  def update
    if @affirmation.update(affirmation_params)
      flash[:success] = "Your affirmation has been updated!"
      redirect_to affirmations_path
    else
      render 'edit'
    end
  end

  def destroy
    @affirmation.destroy
    flash[:warning] = "Your affirmation has been deleted."
    redirect_to affirmations_path
  end

  private

  def set_affirmation
    @affirmation = Affirmation.find(params[:id])
  end

  def require_same_user
    access_denied if @affirmation.user != current_user
  end

  def affirmation_params
    params.require(:affirmation).permit(:text, :user_id)
  end
end