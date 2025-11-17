class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @course = Course.find(params[:course_id])
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_to course_post_path(@post.course, @post), notice: "コメントしました。"
    else
      flash.now[:alert] = "コメントに失敗しました。"
      render 'public/posts/show'
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to course_post_path(@post_comment.post.course, @post_comment.post), notice: "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end