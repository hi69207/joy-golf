class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer

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
    unless @post_comment.customer == current_customer
      redirect_to customer_path(current_customer), alert: "ご自身以外のコメントは編集・削除できません。"
      return
    end
    @post_comment.destroy
    redirect_to course_post_path(@post_comment.post.course, @post_comment.post), notice: "コメントを削除しました。"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_guest_customer
    @customer = current_customer
    if @customer.guest_customer?
      redirect_to request.referer , alert: "ゲスト会員はコメントできません。"
    end
  end
end