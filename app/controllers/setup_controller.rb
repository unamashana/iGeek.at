class SetupController < ApplicationController

  before_filter :authenticate
  layout 'app'
  def index
    @products = Product.all
    @autocomplete_array = @products.map {|p| {:label => p.name, :value => p.id} }
  end
end
