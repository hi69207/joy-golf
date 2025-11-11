class Public::CoursesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @post = Post.new
    @posts = @course.posts.includes(:customer => :prefecture)
                          .order(created_at: :desc) 
                          .page(params[:page]).per(30)
  end
end
