class FriendshipsController < ApplicationController
  include FriendshipsHelper
  before_action :authenticate_user!
  before_action :already_friends, only: [:create]

  def create
    session[:return_to] ||= request.referer
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Friend invite sent."
      redirect_to session.delete(:return_to)
    else
      flash.now[:danger] = "Couldn't add friend."
      redirect_to session.delete(:return_to)
    end

  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attribute(:status, 'friends')
    redirect_to root_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @target_user = User.find(@friendship.friend_id) || User.find(@friendship.user_id)
    Friendship.find(@friendship.id).destroy
    flash[:notice] = "Unfriended #{@target_user.name}"
    redirect_to friends_path
  end

  def index
    @user = current_user
    @friendships = current_user.all_friendships
  end

  private 

    def already_friends
      target_user = User.find(params[:friend_id])
      if friendship_exists?(target_user)
        flash[:message] = "A friendship already exists with that person."
        redirect_to user_path(target_user)
      end
    end

end
