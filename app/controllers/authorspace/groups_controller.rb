class Authorspace::GroupsController < Authorspace::BaseController

  def index
    @groups = policy_scope(Group).includes(:authors)
  end

  def show
    @author = current_author
    @group = Group.find(params[:id])
    authorize @group
  end

  def new
    @group = Group.new
    3.times {@group.memberships.build}
    @author = current_author
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @author = current_author
    authorize @group

    if @group.save
      redirect_to authorspace_author_groups_path
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @author = current_author
    @group = Group.find(params[:id])
    authorize @group
  end

  def update
    @author = current_author
    @group = Group.find(params[:id])
    authorize @group

    if @group.update!(group_params)
      redirect_to authorspace_author_group_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group
    @group.destroy
    redirect_to authorspace_author_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, memberships_attributes: [:id, :author_id, :_destroy])
  end
end
