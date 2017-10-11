class UsersController < ApplicationController

  def downgrade
    @user = current_user
    #check to see if user is premium.  If so downgrade to free
    if @user.has_role? :premium
      @user.remove_role :premium
      flash[:notice] = "You have been downgraded."
    else
      flash[:notice] = "You are already a free user."

    end
      redirect_to root_path
  end
end
