class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]

  def after_sign_in_path_for(_resource)
    customer_path(current_customer)
  end

  def after_sign_out_path_for(resource)
    new_customer_session_path
  end

  private

  def customer_state
    customer = Customer.find_by(name: params[:customer][:name])
    return if customer.nil?
    return unless customer.valid_password?(params[:customer][:password])
    unless customer.is_active?
      redirect_to new_customer_registration_path, alert: "退会済みアカウントです。"
      return
    end
  end
end
