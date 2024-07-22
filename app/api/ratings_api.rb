class RatingsApi < Grape::API
  include AuthMiddleware

  resource :ratings do
    desc 'Create a rating'
    params do
      requires :content_id, type: Integer
      requires :rating, type: Integer, values: 1..5
    end
    post do
      user = @current_user
      content = Content.find(params[:content_id])
      rating = Rating.create!({
        user: user,
        content: content,
        rating: params[:rating]
      })
      { message: 'Rating created successfully', rating: rating }
    rescue ActiveRecord::RecordNotFound => e
      error!({ error: 'Content not found' }, 404)
    rescue ActiveRecord::RecordInvalid => e
      error!({ error: e.message }, 422)
    end
  end
end
