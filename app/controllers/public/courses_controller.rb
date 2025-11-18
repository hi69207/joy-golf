class Public::CoursesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @courses = Course.all
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
