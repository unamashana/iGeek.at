class ProductUsersController < ApplicationController

  before_filter :authenticate
  respond_to  :json

  def create
    @product = Product.find params[:id]

    # user_id is right now ignored
    #
    current_user.products << @product
    respond_with @product
    

  end

  def new
  end

  def index

  end

end
