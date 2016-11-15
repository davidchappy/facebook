class SessionsController < Devise::SessionsController
  before_action :authenticate_user!, except: [:new, :create]

  def new 
    super
  end

  def create 
    super
  end

end