class UsersApi < Grape::API
  resource :users do
    desc 'Create a user'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post do
      User.create!({
        email: params[:email],
        password: params[:password]
      })
    end

    desc 'Authenticate a user'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post 'login' do
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = JWT.encode({ user_id: user.id }, 'secret_key', 'HS256')
        { token: token }
      else
        error!('Unauthorized! Invalid email or password', 401)
      end
    end
  end
end
