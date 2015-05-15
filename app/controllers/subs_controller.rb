class SubsController < ApplicationController
  before_action :validate_permissions, only: [:edit, :update]

  def validate_permissions
    sub = Sub.find(params[:id])
    redirect_to subs_url unless logged_in? && current_user.id == sub.moderator_id
  end

  def index
    @subs = Sub.includes(:moderator)
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:success] = "Sub created!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:success] = "Sub created!"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
