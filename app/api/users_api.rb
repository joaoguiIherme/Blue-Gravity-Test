class UsersApi < Grape::API
  SECRET_KEY = ENV['SECRET_KEY_BASE'] || 'fallback_secret_key'

  resource :users do
    desc 'Create a user'
    params do
      requires :email, type: String
      requires :password, type: String, regexp: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\z/, documentation: { desc: 'Password must be at least 8 characters long and include both letters and numbers.' }
    end
    post do
      begin
        user = User.create!({
          email: params[:email],
          password: params[:password]
        })
        { message: 'User created successfully', user: user }
      rescue ActiveRecord::RecordInvalid => e
        error!({ error: e.message }, 400)
      rescue ActiveRecord::RecordNotUnique => e
        error!({ error: 'Email already exists' }, 400)
      end
    end

    desc 'Authenticate a user'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post 'login' do
      email = params[:email]
      password = params[:password]

      if email.blank? || password.blank?
        error!('Invalid email or password', 400)
        return
      end

      user = User.find_by(email: email)
      if user.nil? || !user.authenticate(password)
        error!('Unauthorized! Invalid email or password', 401)
        return
      end

      token = JWT.encode({ user_id: user.id }, SECRET_KEY, 'HS256')
      { message: 'Login successful', token: token, user: user }
    end
  end
end
