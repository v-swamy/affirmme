class Affirmation < ActiveRecord::Base
  belongs_to :user
  validates :text, presence: true
end