class StoreController < ApplicationController
	include SessionCounter #inlcude the concern session_counter.rb 
	include CurrentCart
	before_action :set_cart
	
  def index
  	@products = Product.order(:title)
  	@counter = increment_session_counter #increase the counter by 1 and update the counter variable
  end

end
