class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :post_owner?, only: [:edit, :update, :destroy]
  before_action :grant_access!, only: [:show]

  def index
    @posts = show_all_dreams.page(params[:page]).per(5)
  end

  def alldreams
    @posts = show_all_dreams.page(params[:page]).per(5)
    render action: 'index'
  end

  def mydreams
    @posts = Post.where(user_id: current_user.id).order("created_at DESC").page(params[:page]).per(5)
    render action: 'index'
  end

  def new
    @post = Post.new
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:notice] = "Dream added successfully."
      redirect_to @post
    else
      render 'new'
    end

  end

  def show
    @post = Post.find(params[:id])
    @user_id = Post.find(params[:id]).user_id
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Dream updated successfully."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Dream deleted successfully."
    redirect_back(fallback_location: root_path)
  end

  def get_author(post_id)
    User.find(Post.find(post_id).user_id).username
  end
  helper_method :get_author

  private
  def post_params
    params.require(:post).permit(:title, :content, :private)
  end

  def show_all_dreams
    if user_signed_in?
      Post.where(user_id: current_user.id).or(Post.where(private: false)).order("created_at DESC")
    else
      Post.where(private: false).order("created_at DESC")
    end
  end

  def post_owner?
    @user_id = Post.find(params[:id]).user_id
    if user_signed_in? && current_user.id == @user_id
      return true
    else
      flash[:notice] = "Access denied."
      redirect_to root_path
    end
  end

  def post_private?
    Post.find(params[:id]).private
  end

  def grant_access!
    if post_private? && post_owner?
      return true
    elsif !post_private?
      return true
    else
      return false
    end
  end
end
