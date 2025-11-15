class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_currect_customer, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.includes(:course => :prefecture)
                          .order(created_at: :desc) 
                          .page(params[:page]).per(30)
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

  private

  def customer_params
    params.require(:customer).permit(:prefecture_id, :name, :address, :history, :email, :is_active, :profile_image)
  end

  def ensure_currect_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end