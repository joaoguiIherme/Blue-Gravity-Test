class BaseApi < Grape::API
  prefix 'api'
  format :json

  mount UsersApi
  mount ContentsApi
  mount RatingsApi

  add_swagger_documentation
end
