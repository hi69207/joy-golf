class Public::CoursesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @prefectures = Prefecture.all
    if params[:prefecture_id].present?
      @courses = Course.where(prefecture_id: params[:prefecture_id])
    else
      @courses = Course.all
    end
  end

  def show
    @course = Course.find(params[:id])
    @post = Post.new
    @posts = @course.posts.includes(:customer => :prefecture)
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
end
