class PostsController < ApplicationController
  before_action :user_is_author, only: [:edit, :update]

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @subs = Sub.all
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:success] = "Post created!"
      redirect_to subs_url
    else
      flash[:error] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def update
    @subs = Sub.all
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "Post updated!"
      redirect_to subs_url
    else
      flash[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments_by_parent_id
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to sub_url(post.sub_id)
  end

  def user_is_author
    post = Post.find(params[:id])
    redirect_to subs_url unless current_user.id == post.author_id
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
