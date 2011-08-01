class Product < ActiveRecord::Base

  mount_uploader :icon, IconUploader
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
  

  validates_presence_of :name
  validates_presence_of :icon

  has_many  :product_users, :dependent => :destroy
  has_many  :users, :through => :product_users
  

end
