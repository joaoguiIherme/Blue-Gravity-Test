require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_attributes) { { email: Faker::Internet.email, password: 'Password123' } }
    let(:invalid_attributes) { { email: '', password: '' } }

    it 'creates a new user' do
      expect {
        post '/api/v1/users', params: valid_attributes
      }.to change(User, :count).by(1)
      
      expect(response).to have_http_status(201)
      expect(response_body['message']).to eq('User created successfully')
    end

    it 'returns an error for invalid attributes' do
      post '/api/v1/users', params: invalid_attributes
      expect(response).to have_http_status(500)
    end
  end

  describe 'POST /api/v1/users/login' do
    let(:user) { create(:user) }
    let(:valid_credentials) { { email: user.email, password: 'Password123' } }
    let(:invalid_credentials) { { email: user.email, password: 'WrongPassword' } }

    it 'authenticates a user with valid credentials' do
      post '/api/v1/users/login', params: valid_credentials
      expect(response).to have_http_status(201)
      expect(response_body['message']).to eq('Login successful')
      expect(response_body).to have_key('token')
    end

    it 'returns an error for invalid credentials' do
      post '/api/v1/users/login', params: invalid_credentials
      expect(response).to have_http_status(401)
    end
  end
end
