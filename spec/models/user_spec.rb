require 'rails_helper'

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }
  it { should validate_uniqueness_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:affirmations) }

  describe "#set_next_affirmation_id" do
    context "next_affirmation_id is nil" do
      it "should set the next_affirmation_id to the user's first affirmation" do
        user = Fabricate(:user)
        affirmation = Fabricate(:affirmation, user: user)
        user.set_next_affirmation_id
        expect(user.next_affirmation_id).to eq(affirmation.id)
      end
    end

    context "next_affirmation_id is not nil" do
      it "should set the next_affirmation_id to the user's next affirmation" do
        user = Fabricate(:user)
        affirmation = Fabricate(:affirmation, user: user)
        affirmation2 = Fabricate(:affirmation, user: user)
        user.set_next_affirmation_id
        user.reload
        user.set_next_affirmation_id
        user.reload
        expect(user.next_affirmation_id).to eq(affirmation2.id)
      end

      context "next_affirmation_id is currently set to user's last affirmation" do
        it "should set the next_affirmation_id to the user's first affirmation" do
          user = Fabricate(:user)
          affirmation = Fabricate(:affirmation, user: user)
          affirmation2 = Fabricate(:affirmation, user: user)
          user.next_affirmation_id = affirmation2.id
          user.save
          user.reload
          user.set_next_affirmation_id
          user.reload
          expect(user.next_affirmation_id).to eq(affirmation.id)
        end
      end
    end
  end
end