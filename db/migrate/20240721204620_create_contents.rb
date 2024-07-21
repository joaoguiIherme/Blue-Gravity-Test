class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :thumbnail_url
      t.string :content_url

      t.timestamps
    end
  end
end
