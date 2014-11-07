class QuitsController < ApplicationController
  def new
    @user = User.find params[:user_id]
    @quit = @user.quits.build
    if current_user.id != params[:user_id] and current_user.admin == false
      flash[:alert] = "Can't create/edit a quit for another person"
      redirect_to root_path
    end
  end

  def create
    @user = User.find params[:user_id]
    @quit = @user.quits.new quit_params
    if @quit.save
      flash[:success] = 'Created!'
      redirect_to @quit.user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:user_id]
    @quit = Quit.find params[:id]
    if current_user.id != params[:user_id] and current_user.admin == false
      flash[:alert] = "Can't create/edit a quit for another person"
      redirect_to root_path
    end
  end

  def update
    @quit = Quit.find params[:id]
    if @quit.update quit_params
      flash[:success] = 'Updated!'
      redirect_to @quit.user
    else
      render 'edit'
    end
  end

  private

  def quit_params
    params.require(:quit).permit(:text)
  end
end
