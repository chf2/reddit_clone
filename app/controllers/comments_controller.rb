class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:success] = "Comment added to post."
      redirect_to post_url(@comment.post_id)
    else
      redirect_to :back
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @comments = @comment.child_comments
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
