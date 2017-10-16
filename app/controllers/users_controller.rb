class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def downgrade
    @user = current_user
    #check to see if user is premium.  If so downgrade to free
    if @user.has_role? :premium
      @user.remove_role :premium
      #loop through existing wikis. Make private wikis public.
      @user.wikis.each do |wiki|
        wiki.private = false
        wiki.save
      end
      flash[:notice] = "You have been downgraded. All of your wikis are now public."
    else
      flash[:notice] = "You are already a free user."

    end
      redirect_to root_path
  end
end
