class GroupsController < ApplicationController


  private

  def group_params
    params.require(:group).permit(memberships_attributes: [:author_id])
  end
end
