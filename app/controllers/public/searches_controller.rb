class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "ゴルファー名"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @courses = Course.looks(params[:search], params[:word])
    end
  end
end
