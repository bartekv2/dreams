class RenameIsPrivateToPrivate < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :published, :private
  end
end
