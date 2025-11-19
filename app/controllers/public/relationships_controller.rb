class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

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
end
