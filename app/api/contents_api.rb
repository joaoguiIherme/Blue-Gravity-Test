class ContentsApi < Grape::API
  include AuthMiddleware

  resource :contents do
    desc 'Return list of contents with ratings'
    get do
      contents = Content.includes(:ratings).map do |content|
        {
          id: content.id,
          title: content.title,
          description: content.description,
          category: content.category,
          thumbnail_url: content.thumbnail_url,
          content_url: content.content_url,
          ratings: content.ratings.pluck(:rating)
        }
      end
      { contents: contents }
    end

    desc 'Create content'
    params do
      requires :title, type: String
      requires :description, type: String
      requires :category, type: String
      requires :thumbnail_url, type: String
      requires :content_url, type: String
    end
    post do
      content = Content.create!({
        title: params[:title],
        description: params[:description],
        category: params[:category],
        thumbnail_url: params[:thumbnail_url],
        content_url: params[:content_url]
      })
      { message: 'Content created successfully', content: content }
    end

    desc 'Update content'
    params do
      requires :id, type: Integer
      optional :title, type: String
      optional :description, type: String
      optional :category, type: String
      optional :thumbnail_url, type: String
      optional :content_url, type: String
    end
    put ':id' do
      content = Content.find(params[:id])
      content.update!(params.slice(:title, :description, :category, :thumbnail_url, :content_url).compact)
      { message: 'Content updated successfully', content: content }
    end

    desc 'Delete content'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      content = Content.find(params[:id])
      content.destroy
      { message: 'Content deleted successfully' }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error!({ error: e.message }, 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error!({ error: e.message }, 422)
  end
end
