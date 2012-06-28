module Spree
  LineItem.class_eval do
    delegate :delivery_required?, :to => :product
  end
end

