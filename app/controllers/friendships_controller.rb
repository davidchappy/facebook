class FriendshipsController < ApplicationController
  before_action :authenticate_user!, :already_friends

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @friendship.save
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attribute(status: 'friends')
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @target_user = User.find(@friendship.friend_id)
    @friendship.destroy
    flash[:notice] = "Unfriended #{@target_user}"
    redirect_to @target_user
  end

  def index
    
  end

end
