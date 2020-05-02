require_relative './part_1_solution.rb'
require 'pry'
def apply_coupons(cart, coupons)
  # Go through each item in both the cart and the coupons list to check if there is a match
  cart.each do |cart_item|
    coupons.each do |coupon_item|
      #binding.pry
      if cart_item[:item] == coupon_item[:item]
        # While enough items exist in the cart to use the coupon, do so
        coupon_applied = cart_item.clone
        coupon_applied[:item] = "#{cart_item[:item]} W/COUPON"
        coupon_applied[:price] = coupon_item[:cost]/coupon_item[:num]
        coupon_applied[:count] = 0
        #binding.pry
        while cart_item[:count] >= coupon_item[:num] do
          coupon_applied[:count] += coupon_item[:num]
          cart_item[:count] -= coupon_item[:num]
          #binding.pry
        end
        cart << coupon_applied
      end
    end
  end
  return cart
end

def apply_clearance(cart)
  # Go through items in cart and check if they are on clearance
  cart.each do |item|
    if item[:clearance] == true
      new_price = item[:price] * 0.8
      item[:price] = new_price.floor(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolodated = consolidate_cart(cart)
  coupons = apply_coupons(consolodated, coupons)
  clearance = apply_clearance(coupons)
  total = 0
  # Add up the total cost of each item * the quantity in cart.
  clearance.each do |item|
    total += item[:price]*item[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
end

cart = [
  {:item => "AVOCADO", :price => 3.00, :clearance => true, count: 5},
  {:item => "KALE", :price => 3.00, :clearance => false, count: 2},
  {:item => "BLACK_BEANS", :price => 2.50, :clearance => false, count: 1},
  {:item => "ALMONDS", :price => 9.00, :clearance => false, count: 2},
  {:item => "TEMPEH", :price => 3.00, :clearance => true, count: 3},
  {:item => "CHEESE", :price => 6.50, :clearance => false, count: 7},
  {:item => "BEER", :price => 13.00, :clearance => false, count: 6},
  {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true, count: 4},
  {:item => "BEETS", :price => 2.50, :clearance => false, count: 4},
  {:item => "SOY MILK", :price => 4.50, :clearance => true, count: 1}
  ]
coupons = [
  {:item => "AVOCADO", :num => 2, :cost => 5.00},
  {:item => "BEER", :num => 2, :cost => 20.00},
  {:item => "CHEESE", :num => 3, :cost => 15.00}
  ]
puts apply_coupons(cart, coupons)