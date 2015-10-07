class AddNextAffirmationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :next_affirmation_id, :integer
  end
end
