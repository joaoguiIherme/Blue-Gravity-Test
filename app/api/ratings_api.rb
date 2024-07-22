class RatingsApi < Grape::API
  include AuthMiddleware

  resource :ratings do
    desc 'Create a rating'
    params do
      requires :content_id, type: Integer
      requires :rating, type: Integer
    end
    post do
      user = @current_user
      content = Content.find(params[:content_id])
      Rating.create!({
        user: user,
        content: content,
        rating: params[:rating]
      })
    end
  end
end
