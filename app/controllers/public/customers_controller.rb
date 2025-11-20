class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_currect_customer, only: [:edit, :update]
  before_action :ensure_guest_customer, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.includes(:course => :prefecture)
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

  def withdraw
    current_customer.update!(is_active: false)
    reset_session
    redirect_to new_customer_session_path, notice: "退会手続きが完了しました。"
  end
  
  def edit
    @prefectures = Prefecture.all
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "会員情報を更新しました。"
    else
      @prefectures = Prefecture.all
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  def following
    @title = "フォロー一覧"
    @customer  = Customer.find(params[:id])
    @customers = @customer.following
    render 'public/relationships/info'
  end

  def followers
    @title = "フォロワー一覧"
    @customer  = Customer.find(params[:id])
    @customers = @customer.followers
    render 'public/relationships/info'
  end

  private

  def customer_params
    params.require(:customer).permit(:prefecture_id, :name, :address, :history, :email, :is_active, :profile_image)
  end

  def ensure_currect_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer), alert: "ご自身以外の会員情報は編集できません。"
    end
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.guest_customer?
      redirect_to customer_path(current_customer) , alert: "ゲスト会員はプロフィール編集できません。"
    end
  end
end