class GroupsController < ApplicationController
  expose(:groups) { current_user.groups }
  expose(:group)

  def create
    group.save
    UserGroup.create(
      :user => current_user,
      :group => group,
      :is_accepted => true,
      :is_owner => true
    )
    respond_with(group)
  end
end
