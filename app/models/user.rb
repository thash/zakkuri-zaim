class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  ### devise :database_authenticatable, :registerable,
  ###        :recoverable, :rememberable, :trackable, :omniauthable
  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :provider, :uid, :token, :token_secret

  def self.find_or_create_user_by_zaim_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first

    if user.blank?
      user = User.create(name: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         token: auth.credentials.token,
                         token_secret: auth.credentials.secret)
    elsif user.token.blank? || user.token_secret.blank?
      user.update_attributes(token: auth.credentials.token,
                             token_secret: auth.credentials.secret)
      return User.where(provider: auth.provider, uid: auth.uid).first
    end
    user
  end
end
