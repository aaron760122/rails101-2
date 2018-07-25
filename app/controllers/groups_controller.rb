class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @groups = Group.new
  end


end
