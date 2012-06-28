module Spree
  CheckoutController.class_eval do

    include ActiveSupport::Callbacks

    define_callbacks :state_action, :terminator => "result == false"

    set_callback :state_action, :before, :redirect_to_appropriate_checkout_state

    private

      # CHANGES - added callbacks around state callback
      def load_order
        @order = current_order
        redirect_to cart_path and return unless @order and @order.checkout_allowed?
        raise_insufficient_quantity and return if @order.insufficient_stock_lines.present?
        redirect_to cart_path and return if @order.completed?
        @order.state = params[:state] if params[:state]

        result = run_callbacks :state_action
        return false unless result # halt

        state_callback(:before)
      end

      # TODO - duplicated logic in Order model
      def redirect_to_appropriate_checkout_state
        if (@order.state == "address" && !@order.address_required?)
          # TODO - duplicated logic in order model
          # confirm is used as if an address is not required it means that a payment and delivery is not required
          redirect_to checkout_state_path("confirm")

          return false # halt
        else
          return true # continue
        end
      end

      alias :before_delivery_without_skip :before_delivery

      def before_delivery
        before_delivery_without_skip

        if @order.rate_hash.count == 1
          # Shipping method is set by before_delivery_without_skip

          if @order.update_attributes(object_params)
            fire_event('spree.checkout.update')

            if @order.next
              state_callback(:after)

              redirect_to checkout_state_path(@order.state)

              return false # halt
            end
          end
        end

        return true # continue
      end

  end
end
