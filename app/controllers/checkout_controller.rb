class CheckoutController < ApplicationController


def create
	
	product = Product.find(params[:id])
	
		@session = Stripe::Checkout::Session.create({
		  payment_method_types: ['card'],
		  line_items: [{
		  	name: product.name,
		  amount: product.price,
            currency: "inr",
            quantity: 1 
		  }],
		  mode: 'payment',
		   success_url: root_url,

		  cancel_url: root_url,

		})
     
	         product.sales_count = product.sales_count + 1    
             product.update(sales_count: product.sales_count)
       
           
		respond_to do |format|
			format.js
        end
	end
end
