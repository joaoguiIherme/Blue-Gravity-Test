class ContentsApi < Grape::API
  include AuthMiddleware

  resource :contents do
    desc 'Return list of contents with ratings'
    get do
      Content.includes(:ratings).map do |content|
        ratings = content.ratings.pluck(:rating)
        { content: content, ratings: ratings }
      end
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
      Content.create!({
        title: params[:title],
        description: params[:description],
        category: params[:category],
        thumbnail_url: params[:thumbnail_url],
        content_url: params[:content_url]
      })
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
      if content
        content.update(params.slice(:title, :description, :category, :thumbnail_url, :content_url).compact)
        { message: 'Content updated successfully', content: content }
      else
        error!({ error: 'Content not found' }, 404)
      end
      
    end

    desc 'Delete content'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      content = Content.find_by(id: params[:id])
      if content
        content.destroy
        { message: 'Content deleted successfully' }
      else
        error!({ error: 'Content not found' }, 404)
      end
    end
  end
end
