module Spree
  ShippingMethod.class_eval do
    def available_to_order?(order, display_on = nil)
      availability_check = available?(order,display_on)
      if order.delivery_required?
        zone_check = zone && zone.include?(order.ship_address)
      else
        zone_check = true
      end
      category_check = category_match?(order)
      availability_check && zone_check && category_check
    end
  end
end
