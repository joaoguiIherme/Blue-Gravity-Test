require 'rails_helper'

RSpec.describe 'Ratings API', type: :request do
  let(:user) { create(:user) }
  let(:content) { create(:content) }
  let(:token) { JWT.encode({ user_id: user.id }, AuthMiddleware::SECRET_KEY, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'POST /api/v1/ratings' do
    let(:valid_attributes) { { content_id: content.id, rating: 5 } }

    it 'creates a new rating' do
      expect {
        post '/api/v1/ratings', params: valid_attributes, headers: headers
      }.to change(Rating, :count).by(1)
      
      expect(response).to have_http_status(201)
      expect(response_body['message']).to eq('Rating created successfully')
    end

    it 'returns an error for invalid attributes' do
      post '/api/v1/ratings', params: { content_id: content.id, rating: 6 }, headers: headers
      expect(response).to have_http_status(500)
    end

    it 'does not have unhandled exceptions' do
      expect {
        post '/api/v1/ratings', params: valid_attributes, headers: headers
      }.not_to raise_error
    end
  end
end
