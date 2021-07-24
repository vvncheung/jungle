class ProductsController < ApplicationController

  def index
    #uses model
    @products = Product.all.order(created_at: :desc)
    # uses view
    # render : index <= implicit return
  end

  def show
    @product = Product.find params[:id]
  end

end
