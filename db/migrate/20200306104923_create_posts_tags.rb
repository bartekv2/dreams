class CreatePostsTags < ActiveRecord::Migration[6.0]
  def change
    create_table :posts_tags, id: false do |t|
      t.integer :tag_id
      t.integer :post_id
    end
  end
end
