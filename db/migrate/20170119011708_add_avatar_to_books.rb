class AddAvatarToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :avatar, :string
  end
end
