class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

def new
    @prefectures = Prefecture.all
    super # Deviseの元のnewアクションを呼び出す
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys:[:prefecture_id, :name, :address, :history, :email])
  end

  def after_sign_up_path_for(_resource)
    root_path
  end
end
