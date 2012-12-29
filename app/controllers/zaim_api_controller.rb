# coding: utf-8
class ZaimApiController < ApplicationController
  before_filter :authenticate_user!
  def pay
    z = ZaimApi.new(current_user.token, current_user.token_secret)
    z.pay!( params["category_id"], params["genre_id"], params["price"] )
    flash[:notice] = "記録しました"
  rescue ZaimApi::UnauthorizedError
    flash[:alert] = "認証エラーが発生"
  rescue ZaimApi::ResponseError
    flash[:alert] = "APIエラーが発生"
  ensure
    redirect_to root_path
  end
end
