module Spree
  Order.class_eval do

    register_update_hook :set_delivery_required

    # CHANGES - allow transition straight from cart to confirm if no delivery or payment is required
    # CHANGES - allow transition straight from address to payment if no delivery is required
    # cart -> address -> delivery -> payment -> confirm -> complete
    state_machine do
      event :next do
        reset

        transition :from => 'cart',     :to => 'address', :if => :address_required?
        transition :from => 'cart',     :to => 'confirm'

        transition :from => 'address',  :to => 'delivery', :if => :delivery_required?
        transition :from => 'address',  :to => 'payment', :if => :payment_required?
        transition :from => 'address',  :to => 'confirm'

        transition :from => 'delivery', :to => 'payment', :if => :payment_required?
        transition :from => 'delivery', :to => 'confirm'

        transition :from => 'confirm',  :to => 'complete'

        # note: some payment methods will not support a confirm step
        transition :from => 'payment',  :to => 'confirm',
                                        :if => Proc.new { |order| order.payment_method && order.payment_method.payment_profiles_supported? }
        transition :from => 'payment', :to => 'complete'
      end
    end

    def address_required?
      delivery_required? || payment_required?
    end

    private

      def set_delivery_required
        self.delivery_required = line_items.any?(&:delivery_required?)

        update_attributes_without_callbacks({
          :delivery_required => delivery_required
        })
      end

      # CHANGES: Added delivery_required
      def has_available_shipment
        return unless delivery_required?
        return unless :address == state_name.to_sym
        return unless ship_address && ship_address.valid?
        errors.add(:base, :no_shipping_methods_available) if available_shipping_methods.empty?
      end

  end
end
