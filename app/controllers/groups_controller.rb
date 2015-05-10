class GroupsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
  	@groups = Group.all
  end

  def show
     @group = Group.find(params[:id])
     @posts = @group.posts
  end

  def new

    @group = current_user.groups.new

  end

  def edit

    @group = current_user.groups.find(params[:id])


  end

  def create

    @group = current_user.groups.new(group_params)

    if @group.save 
      current_user.join!(@group)
      name = @group.title
      redirect_to groups_path, :notice => "OK! Group #{name}"
    else
      render :new
    end

  end

  def update

    @group = current_user.groups.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, :notice => 'OK Edit'
    else
      render :edit
    end


  end

  def destroy

    @group = Group.find(params[:id])

    @group.destroy
    redirect_to groups_path, :alert => 'Delete OK'

  end

  def join
    @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Thank for join this group!!!"
    else
      flash[:warning] = "You are already a member of this group!"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "Bye Bye"
    else
      flash[:warning] = "Not a member."
    end

    redirect_to group_path(@group)
  end

  private

  def group_params
      params.require(:group).permit(:title, :description)
  end



end
