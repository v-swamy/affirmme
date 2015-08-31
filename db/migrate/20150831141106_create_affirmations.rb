class CreateAffirmations < ActiveRecord::Migration
  def change
    create_table :affirmations do |t|
      t.text :text
      t.integer :user_id
      t.timestamps
    end
  end
end
