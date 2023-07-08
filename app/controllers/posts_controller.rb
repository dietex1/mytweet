class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @comment = Comment.new
  end




  def my_posts
    @posts = Current.user.posts
    render 'my_posts'
  end


  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  # def create_comment
  #   @post = Post.find(params[:id])
  #   @comment = @post.comments.build(comment_params)
  #   @comment.user = Current.user
  #   if @comment.save
  #     redirect_to post_path(@post), notice: 'Comment created successfully.'
  #   else
  #     render :show
  #   end
  # end
  def create_comment
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment created successfully.'
    else
      @comments = @post.comments
      render 'show'
    end
  end


  # @post = Post.find(params[:post_id])
  # @comment = @post.comments.build(comment_params.merge(user_id: Current.user.id))
  #
  # if @comment.save
  #   redirect_to post_path(@post), notice: 'Comment created successfully.'
  # else
  #   flash[:alert] = 'Failed to create comment.'
  #   redirect_to post_path(@post)
  # end







  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted successfully.'
  end


  private
  def post_params
    params.require(:post).permit(:title, :photo, :text)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end





end
