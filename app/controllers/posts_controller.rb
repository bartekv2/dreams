class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :post_owner_or_admin?, only: [:edit, :update, :destroy]
  before_action :grant_access!, only: [:show]

  def index
    @posts = show_all_dreams(Post.all).order("created_at DESC").page(params[:page]).per(8)
  end

  def mydreams
    @posts = Post.where(user_id: current_user.id).order("created_at DESC").page(params[:page]).per(8)
    render action: 'index'
  end

  def dreams_by_tag
    @tag = Tag.find_by id: params[:tag_id]
    @posts = show_all_dreams(@tag.posts).order("created_at DESC").page(params[:page]).per(8)
    render action: 'index'
  end

  def userdreams
    @posts = show_all_dreams(Post.all).where(user_id: params[:user_id]).order("created_at DESC").page(params[:page]).per(8)
    @user = User.find(params[:user_id]).username
    if user_signed_in? && current_user.username == @user
      redirect_to controller: :posts, action: :mydreams, method: :post
    else
      render action: 'index'
    end
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
    @user_id = @post.user_id
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Dream updated successfully."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @post.destroy
    flash[:notice] = "Dream deleted successfully."
    redirect_to posts_path
  end

  def get_author_by_post_id(post_id)
    User.find(Post.find(post_id).user_id).username
  end
  helper_method :get_author_by_post_id

  private
  def post_params
    params.require(:post).permit(:title, :content, :private, tag_ids:[])
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def show_all_dreams(posts)
    if current_user.try(:admin?)
      posts
    elsif user_signed_in?
      posts.where(user_id: current_user.id).or(posts.where(private: false))
    else
      posts.where(private: false)
    end
  end

  def post_owner_or_admin?
    @user_id = Post.find(params[:id]).user_id
    if (user_signed_in? && current_user.id == @user_id) || current_user.admin?
      return true
    else
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

  def post_private?
    Post.find(params[:id]).private
  end

  def grant_access!
    if post_private? && post_owner_or_admin?
      return true
    elsif !post_private?
      return true
    else
      return false
    end
  end
end
