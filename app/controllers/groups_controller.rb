class GroupsController < ApplicationController

  def index
  	@groups = Group.all
  end

  def show
     @group = Group.find(params[:id])
  end

  def new

    @group = Group.new

  end

  def edit

    @group = Group.find(params[:id])


  end

  def create

    @group = Group.new(group_params)

    if @group.save 
      name = @group.title
      redirect_to groups_path, :notice => "OK! Group #{name}"
    else
      render :new
    end

  end

  def update

    @group = Group.find(params[:id])

    if @group.update(group_params)
      redirect_to groups_path, :notice => 'OK Edit'
    else
      render :edit
    end


  end

  def destroy
  end

  private

  def group_params
      params.require(:group).permit(:title, :description)
  end



end
