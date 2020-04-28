require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  coupons.each_index do |c|
    cart.each_index do |i|
      if cart[i].has_value?(coupons[c][:item])
        cart[i][:count] -= coupons[c][:num]
      end
    end
    nh = {}
    # do this before you change the name in the cart
    if find_item_by_name_in_collection(coupons[c][:item], cart)[:clearance] == true
      nh[:clearance] = true
    else
      nh[:clearance] = false
    end
    nh[:item] = coupons[c][:item] += " W/COUPON"
    nh[:price] = coupons[c][:cost] / coupons[c][:num]
    nh[:count] = coupons[c][:num]
    cart.append(nh)
  end
  cart
end

def apply_clearance(cart)
  # REMEMBER: This method **should** update cart
  cart.each_index do |i|
    if cart[i][:clearance] == true
      cart[i][:price] = cart[i][:price] - (cart[i][:price] * 0.2) # add in .round() here if you need it
    end
  end
  cart
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
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  discount = 0
  total = 0
  cart.each_index do |i|
    total += cart[i][:price] * cart[i][:count]
  end
  if total > 100
    discount = total * 0.1
  end
  return total - discount
end
