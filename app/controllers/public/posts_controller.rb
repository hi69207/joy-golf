class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

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
  end

  def edit
    @post = Post.find(params[:id])
    @course = @post.course
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to course_post_path(@post.course, @post), notice: "更新しました。"
    else
      @course = @post.course
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to customers_my_page_path, notice: "削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:round_day, :score, :sentence)
  end
end
