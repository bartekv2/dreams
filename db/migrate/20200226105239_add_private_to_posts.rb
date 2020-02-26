class AddPrivateToPosts < ActiveRecord::Migration[6.0]
  def change
    unless column_exists? :posts, :private
      add_column :posts, :private, :boolean
    end
  end
end
