module RequestSpecHelper
  def token_generator(user_id)
    JWT.encode({ user_id: user_id }, AuthMiddleware::SECRET_KEY, 'HS256') if user_id.present?
  end

  def valid_headers
    user = create(:user)
    return nil unless user.present?
    {
      "Authorization" => "Bearer #{token_generator(user.id)}"
    }
  end

  def response_body
    JSON.parse(response.body) if response.body.present?
  rescue JSON::ParserError
    nil
  end
end

RSpec.configure do |config|
  config.include RequestSpecHelper, type: :request
end

