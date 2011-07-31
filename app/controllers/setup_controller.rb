class SetupController < ApplicationController

  before_filter :authenticate
  layout 'app'

  def index
    @products = Product.all
    @already_using = current_user.products
    @autocomplete_array = @products.map {|p| {:label => p.name, :value => p.id} }
    @popular = (@products - @already_using)[1..6]
  end

end
