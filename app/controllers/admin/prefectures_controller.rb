class Admin::PrefecturesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @prefecture = Prefecture.new
    @prefectures = Prefecture.all
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      redirect_to admin_prefectures_path, notice: "都道府県を登録しました。"
    else
      @prefectures = Prefecture.all
      flash.now[:alert] = "登録が失敗しました。"
      render :index
    end
  end

  def edit
    @prefecture = Prefecture.find(params[:id])
  end

  def update
    @prefecture = Prefecture.find(params[:id])
    if @prefecture.update(prefecture_params)
      redirect_to admin_prefectures_path, notice: "更新しました。"
    else
      flash.now[:alert] = "更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @prefecture = Prefecture.find(params[:id])
    @prefecture.destroy
    redirect_to admin_prefectures_path, notice: "削除しました。"
  end

  private

  def prefecture_params
    params.require(:prefecture).permit(:name, :latitude, :longitude, :prefecture_image)
  end
end
