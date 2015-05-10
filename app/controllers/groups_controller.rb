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

  private

  def group_params
      params.require(:group).permit(:title, :description)
  end



end
