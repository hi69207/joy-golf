class Public::HomesController < ApplicationController

  def top
    @prefectures = Prefecture.all
    @posts = Post.includes(
      :customer => :prefecture, 
      :course => :prefecture
    )

    if params[:prefecture_id].present?
      course_ids = Course.where(prefecture_id: params[:prefecture_id]).pluck(:id)
      @posts = @posts.where(course_id: course_ids)
    end

    if params[:latest]
      @posts = @posts.latest
    elsif params[:old]
      @posts = @posts.old
    elsif params[:difficulty]
      @posts = @posts.difficulty
    elsif params[:ease]
      @posts = @posts.ease
    else
      @posts = @posts.latest 
    end

    @posts = @posts.page(params[:page]).per(10)

  end

  def about
  end
end
