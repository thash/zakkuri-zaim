# coding: utf-8
class ZaimApi # < ActiveRecord::Base #NOTE
  class ResponseError < StandardError; end

  # attr_accessible :access_token, :access_token_secret #NOTE
  attr_accessor :consumer

  def initialize(consumer_key, consumer_secret)
    @consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                    #site: 'https://api.zaim.net/',
                                    request_token_path: $secret.Request_token_URL,
                                    authorize_path: $secret.Authorize_URL,
                                    access_token_path: $secret.Access_token_URL)
  end

  def access_token
    OAuth::AccessToken.from_hash(self.consumer,
                                 oauth_token: $secret.Access_token,
                                 oauth_token_secret: $secret.Access_token_secret)
  end

  # Zaim APIを介して記録を行う
  def pay!(category_id, genre_id, price)
    raise ArgumentError if price >= 0 # 出費限定なのでpriceは負であるべき
    input = {
      category_id: category_id,
      genre_id: genre_id,
      price: price,
      date: Time.now.strftime("%Y-%m-%d")
    }
    res = access_token.post("https://api.zaim.net/v1/pay/create.json", input)
    raise ResponseError if res.code != "200"
    p res.body
  end

end
