class AddStatusToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :status, :string, default: 'none'
  end
end
