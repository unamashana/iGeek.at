class User < ActiveRecord::Base

  validates_presence_of :provider, :uid, :name

  def apply_omniauth(auth) 
    provider = auth["provider"]
    uid = auth["uid"] 
    name = auth["user_info"]["name"]
  end   
end
