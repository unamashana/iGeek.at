class Product < ActiveRecord::Base

  mount_uploader :icon, IconUploader

  validates_presence_of :name
  validates_presence_of :icon

  has_many  :product_users
  has_many  :users, :through => :product_users
  

end
