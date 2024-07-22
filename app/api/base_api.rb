class BaseApi < Grape::API
  prefix 'api'
  format :json

  namespace :v1 do
    mount UsersApi
    mount ContentsApi
    mount RatingsApi
  end

  before do
    header 'Access-Control-Allow-Origin', '*'
    header 'Access-Control-Request-Method', '*'
  end

  rescue_from :all do |e|
    error!(message: "Internal server error: #{e.message}", status: 500)
  end

  add_swagger_documentation
end
