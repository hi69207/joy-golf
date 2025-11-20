class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @prefectures = Prefecture.all
    @posts = @customer.posts.includes(:course => :prefecture)

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

  def edit
    @customer = Customer.find(params[:id])
    @prefectures = Prefecture.all
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました。"
    else
      @prefectures = Prefecture.all
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:prefecture_id, :name, :address, :history, :email, :is_active, :profile_image)
  end
end