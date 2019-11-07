require "application_system_test_case"
	include ActiveJob::TestHelper

class OrdersTest < ApplicationSystemTestCase
	test "check routing number" do

		LineItem.delete_all
		Order.delete_all

		visit store_index_url

		first('.catalog li').click_on 'Add to Cart'

		click_on 'Checkout'

		fill_in 'order_name', with: 'Dave Thomas'
		fill_in 'order_address', with: '123 Main Street'
		fill_in 'order_email', with: 'dave@example.com'

		assert_no_selector "#order_routing_number"

		select 'Check', from: 'pay_type'

		assert_selector "#order_routing_number"	

		fill_in "Routing #", with: "123456"
		fill_in "Account #", with: "987654"
	end	

end