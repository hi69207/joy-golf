class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(
      :customer => :prefecture, 
      :course => :prefecture
    )
    .order(created_at: :desc) 
    .page(params[:page]).per(10)
  end

  def about
  end
end
