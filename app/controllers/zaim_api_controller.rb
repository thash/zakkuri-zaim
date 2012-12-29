# coding: utf-8
class ZaimApiController < ApplicationController
  def pay
    zaimapi.pay!( params["category_id"], params["genre_id"], params["price"] )
    flash[:notice] = "記録しました"
  rescue ZaimApi::UnauthorizedError
    flash[:alert] = "認証エラーが発生"
  rescue ZaimApi::ResponseError
    flash[:alert] = "APIエラーが発生"
  ensure
    redirect_to root_path
  end

  def zaimapi
    return nil unless signed_in?
    # リクエスト回数を減らすためインスタンス変数化してnil guard
    @zaimapi ||= ZaimApi.new(current_user.token, current_user.token_secret)
  end
end
