class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :about]

  def index
  end

  def about
  end
end
