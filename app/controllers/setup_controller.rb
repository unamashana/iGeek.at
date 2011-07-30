class SetupController < ApplicationController

  before_filter :authenticate

  def index
    @products = Product.all
  end
end
