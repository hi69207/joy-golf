class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def withdraw
    current_customer.update!(is_active: false)
    reset_session
    redirect_to root_path, notice: "退会手続きが完了しました。"
  end
  
  def edit
    @customer = current_customer
    @prefectures = Prefecture.all
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:prefecture_id, :name, :address, :history, :email, :is_active, :profile_image)
  end
end