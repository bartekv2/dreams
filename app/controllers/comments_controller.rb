class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @name = current_user.username
    @comment = @post.comments.create(params.require(:comment).permit(:name, :comment))
    if @comment.save
      flash[:notice] = "Comment added successfully."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment can't be blank."
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted successfully."
    redirect_to post_path(@post)
  end
end
