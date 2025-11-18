class Public::HomesController < ApplicationController

  def top
    @posts = Post.includes(
      :customer => :prefecture, 
      :course => :prefecture
    )
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

  def about
  end
end
