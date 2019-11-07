require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @order = orders(:one)
    @product = products(:ruby)
  end

  test "require item in cart" do
  	get new_order_url
  	assert_redirected_to store_index_path
  	assert_equal flash[:notice], 'your cart is empty'
  end

  test "should get new" do
  	post line_items_url, params: { product_id: @product.id }
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    end
    assert_redirected_to store_index_url(locale: 'en')
  end
end
