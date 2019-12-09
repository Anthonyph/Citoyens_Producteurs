class UsersController < ApplicationController
  def show
    @events = Event.all
  end
end
