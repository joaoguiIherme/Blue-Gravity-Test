class RatingsApi < Grape::API
  resource :ratings do
    desc 'Create a rating'
    params do
      requires :content_id, type: Integer
      requires :rating, type: Integer
    end
    post do
      user = User.find_by(email: headers['X-User-Email'])
      error!('Unauthorized', 401) unless user

      content = Content.find(params[:content_id])
      Rating.create!({
        user: user,
        content: content,
        rating: params[:rating]
      })
    end
  end
end
