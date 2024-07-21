class ContentsApi < Grape::API
  resource :contents do
    desc 'Return list of contents'
    get do
      Content.all
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
      content.update({
        title: params[:title],
        description: params[:description],
        category: params[:category],
        thumbnail_url: params[:thumbnail_url],
        content_url: params[:content_url]
      })
      content
    end

    desc 'Delete content'
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      Content.find(params[:id]).destroy
    end
  end
end
