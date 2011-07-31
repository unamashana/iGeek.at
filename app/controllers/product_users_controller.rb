class ProductUsersController < ApplicationController

  before_filter :authenticate
  respond_to  :json

  def create
    @product = Product.find params[:id]

    # user_id is right now ignored
    #
    current_user.products << @product
    #respond_with @product

    render :update do |page|
      page["#list"].prepend render :partial => 'products/product', :locals => {:product => @product}
    end
    

  end

  def new
  end

  def index

  end

end
