require 'rails_helper'

RSpec.describe User, type: :model do
    # before(:each) do
    #     create(:user)
    # end
    
    subject(:user) do
        FactoryBot.build(:user,
            username: 'superman',
            password: 'password'
        )
    end

    describe 'should validate params' do 
        it { should validate_presence_of(:username) } 
        it { should validate_presence_of(:session_token) } 
        it { should validate_presence_of(:password_digest) } 
        it { should validate_length_of(:password).is_at_least(6) } 
        it { should validate_uniqueness_of(:username) }
        it { should validate_uniqueness_of(:session_token) } 
    end

    describe '::find_by_credentials' do 
        before { user.save! }
        # user = User.create!(username: "pantsman", password: "password")
        it 'accept a username and password' do 
            expect(User.find_by_credentials("superman", "password")).to eq(user)
        end

        it 'invalid parameters' do 
            expect(User.find_by_credentials("superman", 9000)).to eq(nil)
        end
    end

    describe 'is_password?' do
        before { user.save! }

        context 'accept password' do
            it 'return true if password matches' do
                expect(user.is_password?('password')).to be true
            end
            
            it "return false if password doesn't match" do
                expect(user.is_password?('pass')).to be false
            end
        end

    end

    describe 'reset_session_token!' do
        before { user.save! }

        it 'session token is reset' do
            token = user.session_token
            user.reset_session_token!

            expect(user.session_token).not_to eq(token)
        end
    end

end