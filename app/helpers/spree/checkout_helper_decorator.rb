module Spree
  CheckoutHelper.module_eval do

    # TODO - duplicated logic in order model
    def checkout_states
      states = []
      states << "address" if @order.address_required?
      states << "delivery" if @order.delivery_required?
      states << "payment" if @order.payment_required?
      states << "confirm" if !@order.payment_required? || (@order.payment && @order.payment.payment_method.payment_profiles_supported?)
      states << "complete"
      states
    end

  end
end
