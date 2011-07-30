class ProductUser < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :user

  validates_presence_of :user, :product

  validates_uniqueness_of :product_id, :scope => :user_id

end
