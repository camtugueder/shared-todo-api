class GroupsController < ApplicationController
  def all_details
    groups = Group.includes(friends: :tasks).all
    render json: groups, include: ['friends', 'friends.tasks']
  end
end
