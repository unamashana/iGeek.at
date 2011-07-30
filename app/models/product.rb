class Product < ActiveRecord::Base

  mount_uploader :icon, IconUploader

  validates_presence_of :name
  validates_presence_of :icon

  

end
