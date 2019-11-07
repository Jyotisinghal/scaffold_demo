class StoreController < ApplicationController
  skip_before_action :authorize
  
  include CurrentCart
  before_action :set_cart
  before_action :session_counter, only: [:index]
  
  def index
    if params[:set_locale]
      redirect_to store_index_path(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end

  private

  def session_counter
  	if session[:counter].nil?
  		session[:counter] = 0
  	else
  		session[:counter] += 1
  	end
  end
end
