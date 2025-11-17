class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_currect_customer, only: [:edit, :update, :destroy]

  def create
    @course = Course.find(params[:course_id])
    @post = @course.posts.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to course_post_path(@course, @post), notice: "投稿しました。"
    else
      @posts = @course.posts.includes(:customer => :prefecture)
                            .order(created_at: :desc) 
                            .page(params[:page]).per(30)
      flash.now[:alert] = "投稿が失敗しました。"
      render 'public/courses/show'
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @course = @post.course
  end

  def update
    if @post.update(post_params)
      redirect_to course_post_path(@post.course, @post), notice: "更新しました。"
    else
      @course = @post.course
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to customer_path(current_customer), notice: "削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:round_day, :score, :sentence)
  end

  def ensure_currect_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to customer_path(current_customer), alert: "ご自身以外の投稿は編集・削除できません。"
    end
  end
end
