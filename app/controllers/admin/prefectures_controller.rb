class Admin::PrefecturesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @prefecture = Prefecture.new
    @prefectures = Prefecture.all
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      redirect_to admin_prefectures_path, notice: "You have created book successfully."
    else
      @prefectures = Prefecture.all
      render 'index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

    private

  def prefecture_params
    params.require(:prefecture).permit(:name, :latitude, :longitude, :prefecture_image)
  end
end
