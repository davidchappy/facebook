class ChangeDefaultStatusInFriendships < ActiveRecord::Migration[5.0]
  def change
    remove_column   :friendships, :status
    add_column      :friendships, :status, :string, default: "pending"
  end
end
