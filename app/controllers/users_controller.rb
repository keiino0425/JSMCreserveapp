class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def choice
    @teachers = Teacher.all
  end
end
