class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @targets = Target.where(user_id: @user)
    # @targets = Target.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新が成功しました"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
