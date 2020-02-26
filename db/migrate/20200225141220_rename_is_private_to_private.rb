class RenameIsPrivateToPrivate < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :is_private, :private
  end
end
