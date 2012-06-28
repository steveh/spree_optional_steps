module Spree
  Product.class_eval do
    delegate :delivery_required?, :to => :shipping_category
  end
end
