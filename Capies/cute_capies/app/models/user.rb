class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: true 
    validates :password, presence: true, length: { minimum: 6, allow_nil: true }
    
    
end