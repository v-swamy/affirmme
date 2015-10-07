class User < ActiveRecord::Base
  has_many :affirmations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  has_secure_password

  def set_next_affirmation_id
    if self.next_affirmation_id == nil || self.next_affirmation_id == self.affirmations.last.id
      self.next_affirmation_id = self.affirmations.first.id
      self.save
    else
      next_id = Affirmation.where("id > ?", self.next_affirmation_id).first.id
      self.next_affirmation_id = next_id
      self.save
    end
  end
end