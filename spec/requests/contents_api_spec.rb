require 'rails_helper'

RSpec.describe 'Contents API', type: :request do
  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, AuthMiddleware::SECRET_KEY, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'GET /api/v1/contents' do
    let!(:contents) { create_list(:content, 3) }

    it 'returns a list of contents' do
      get '/api/v1/contents', headers: headers
      expect(response).to have_http_status(200)
      expect(response_body['contents'].size).to eq(3)
    end
  end

  describe 'POST /api/v1/contents' do
    let(:valid_attributes) { attributes_for(:content) }

    it 'creates a new content' do
      expect {
        post '/api/v1/contents', params: valid_attributes, headers: headers
      }.to change(Content, :count).by(1)
      
      expect(response).to have_http_status(201)
      expect(response_body['message']).to eq('Content created successfully')
    end
  end

  describe 'PUT /api/v1/contents/:id' do
    let(:content) { create(:content) }
    let(:new_attributes) { { title: 'Updated Title' } }

    it 'updates an existing content' do
      put "/api/v1/contents/#{content.id}", params: new_attributes, headers: headers
      content.reload
      expect(content.title).to eq('Updated Title')
      expect(response).to have_http_status(200)
      expect(response_body['message']).to eq('Content updated successfully')
    end
  end

  describe 'DELETE /api/v1/contents/:id' do
    let!(:content) { create(:content) }

    it 'deletes a content' do
      expect {
        delete "/api/v1/contents/#{content.id}", headers: headers
      }.to change(Content, :count).by(-1)
      
      expect(response).to have_http_status(200)
      expect(response_body['message']).to eq('Content deleted successfully')
    end
  end
end
