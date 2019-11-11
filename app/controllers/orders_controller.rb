class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
	include CurrentCart
	before_action :set_cart, only: [:new, :create]
	before_action :ensure_cart_is_not_empty, only: [:new]
  

  def index
    @orders = Order.order(:name)
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    respond_to do |format|
  		if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        ChargeOrderJob.perform_later(@order,pay_type_params)
        OrderMailer.received(@order).deliver_later
  			format.html { redirect_to store_index_url(locale: I18n.locale), notice: I18n.t('.thanks')}
  		else
  			format.html { render :new }
  		end
  	end
  end

  def destroy
    @order = Order.find[:id]
    @order.destroy
    redirect_to store_index_path, notice: "you deleted order"
  end


  private

  def pay_type_params
    if order_params[:pay_type] == "Credit card"
      params.require(:order).permit(:credit_card_number, :expiration_date)
    elsif order_params[:pay_type] == "Check"
      params.require(:order).permit(:routing_number, :account_number)
    elsif order_params[:pay_type] == "Purchase order"
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end

  def order_params
  	params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def ensure_cart_is_not_empty
  	if @cart.line_items.empty?
  		redirect_to store_index_url, notice: 'your cart is empty'
  	end	
  end
end
