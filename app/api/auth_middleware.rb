module AuthMiddleware
  SECRET_KEY = ENV['SECRET_KEY_BASE'] || 'fallback_secret_key'

  def self.included(base)
    base.before do
      token = headers['Authorization']&.then { |header| header.split(' ').last }
      if token
        begin
          payload = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256').first
          @current_user = User.find_by(id: payload['user_id'])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
          error!('Unauthorized', 401)
          Rails.logger.error("Error decoding token: #{e}")
        end
      else
        error!('Token missing', 401)
      end
    end
  end
  def current_user
    @current_user
  end
end
