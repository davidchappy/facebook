module FriendshipsHelper

  def friendship_exists?(target_user, user=current_user)
    Friendship.where("user_id = ? AND friend_id = ?", user.id, target_user.id).exists?
  end

end
