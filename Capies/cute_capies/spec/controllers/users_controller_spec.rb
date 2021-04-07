require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
    describe "#new" do 
        it "start sign up process" do 
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "#create" do 
        it "with invalid params, renders the new template" do 
            post :create, user: { username: "superman" }
            expect(response).to render_template(:new)
        end
        it "with valid params, renders the new template" do 
            post :create, user: { username: "superman", password: "password" }
            expect(response).to redirect_to(user_url(User.find_by(username: "superman")))
        end
    end

    describe "#show" do 
        it "if successful, renders show page" do 
            User.create!(username: "superman", password: "password")
            get :show, id: 1 
            expect(response).to render_template(:show)
        end
        it "not successful" do 
            begin
               get :show, id: -1 
            rescue => exception
                ActiveRecord::RecordNotFound
            end
            expect(response).not_to render_template(:show)
        end
    end
end