class Admin::CoursesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @course = Course.new
    @courses = Course.all
    @prefectures = Prefecture.all
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_path(@course), notice: "コースを登録しました。"
    else
      @courses = Course.all
      @prefectures = Prefecture.all
      render :index
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])
    @prefectures = Prefecture.all
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:prefecture_id, :name, :address, :latitude, :longitude, :is_active, :course_image)
  end
end
