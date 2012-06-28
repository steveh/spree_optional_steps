module Spree
  ShippingCategory.class_eval do
    attr_accessible :delivery_required
  end
end
