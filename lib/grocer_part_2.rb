require_relative './part_1_solution.rb'
require "pry"

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    n = 0
    while n < cart.length do
      current_item_hash = cart[n]
      if coupon[:item] == current_item_hash[:item]
        if current_item_hash[:count] >= coupon[:num]
          number_of_full_priced_items = current_item_hash[:count] % coupon[:num]
          number_of_sale_items = current_item_hash[:count] - number_of_full_priced_items
          new_cost_per_sale_item = coupon[:cost]/coupon[:num]
          current_item_hash[:count] = number_of_full_priced_items
          current_item_name = current_item_hash[:item]
          cart << {:item => "#{current_item_name} W/COUPON", :price => new_cost_per_sale_item, :clearance => current_item_hash[:clearance], :count => number_of_sale_items}
        end
      end
      n += 1
    end
  end
  cart
end

def apply_clearance(cart)
  new_cart = []
  cart.each do |grocery_items|
    if grocery_items[:clearance]
      grocery_items[:price] = (grocery_items[:price] * 0.8).round(2)
    end
  new_cart << grocery_items
  end
  new_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(cart_with_coupons)
  total_price = 0
  final_cart.each do |item|
    item_price_total = item[:price] * item[:count]
    item_price_total.round(2)
    total_price += item_price_total
  end
  if total_price > 100
    total_price = (total_price * 0.9).round(2)
  end
  total_price
end
