require 'rails_helper'

RSpec.describe User, type: :model do
    # before(:each) do
    #     create(:user)
    # end
    

    describe 'should validate params' do 
        it { should validate_presence_of(:username) } 
        it { should validate_presence_of(:session_token) } 
        it { should validate_presence_of(:password_digest) } 
        it { should validate_length_of(:password).is_at_least(6) } 
        it { should validate_uniqueness_of(:username) }
        it { should validate_uniqueness_of(:session_token) } 
    end

    describe '::find_by_credentials' do 
        # user = User.create!(username: "pantsman", password: "password")
        it 'accept a username and password' do 
            expect(User.find_by_credentials("superman", "password")).to eq(user)
        end

        it 'invalid parameters' do 
            expect(User.find_by_credentials("superman", 9000)).to eq(nil)
        end
    end

end