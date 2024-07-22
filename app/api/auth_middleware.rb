module AuthMiddleware
  def self.included(base)
    base.before do
      token = headers['Authorization']&.split(' ')&.last
      begin
        payload = JWT.decode(token, 'secret_key', true, { algorithm: 'HS256' }).first
        @current_user = User.find(payload['user_id'])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        error!('Unauthorized', 401)
      end
    end
  end

  def current_user
    @current_user
  end
end
