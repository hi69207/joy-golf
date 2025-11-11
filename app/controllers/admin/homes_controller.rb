class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.includes(
      :customer => :prefecture, 
      :course => :prefecture
    )
    .order(created_at: :desc) 
    .page(params[:page]).per(10)
  end
end
