class TargetsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update,]

  def new
    @target = Target.new
  end

  def create
    @target = Target.new(target_params)
    @target.user_id = current_user.id
    if @target.save
      redirect_to user_path(current_user), notice: "目標を登録しました"
    else
      render :new
    end
  end

  def index
    @targets = Target.all
  end

  def show
    @target = Target.find(params[:id])
    @comment = TargetComment.new
  end

  def edit
  end

  def update
    if @target.update(target_params)
      redirect_to user_path(current_user), notice: "更新しました"
    else
      render :edit
    end
  end

  private

  def target_params
    params.require(:target).permit(:title, :description)
  end

  def ensure_correct_user
    @target = Target.find(params[:id])
    unless @target.user == current_user
      redirect_to root_path, alert: "不正なアクセスです"
    end
  end
end
