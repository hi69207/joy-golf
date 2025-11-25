class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer

  def create
    customer = Customer.find(params[:followed_id])
    current_customer.follow(customer)
    redirect_to request.referer
  end

  def destroy
    customer = Relationship.find(params[:id]).followed
    current_customer.unfollow(customer)
    redirect_to request.referer
  end

  private

  def ensure_guest_customer
    if current_customer.guest_customer?
      redirect_to request.referer, alert: "ゲスト会員はフォロー/アンフォロー操作を行えません。"
    end
  end
end
