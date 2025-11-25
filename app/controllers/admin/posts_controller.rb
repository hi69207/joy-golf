class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

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
      redirect_to admin_course_post_path(@post.course, @post), notice: "更新しました。"
    else
      @course = @post.course
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_customer_path(@post.customer), notice: "削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:round_day, :golf_score, :sentence, :score)
  end
end
