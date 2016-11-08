module FriendshipsHelper

  def friendship_exists?(target_user, user=current_user)
    Friendship.where("user_id = ? AND friend_id = ?", user.id, target_user.id).exists?
  end

  def already_friends
    target_user = User.find(params[:friend_id])
    if friendship_exists?(target_user)
      flash[:message] = "You've already asked that person to be your friend"
      redirect_to user_path(target_user)
    end
  end

end
