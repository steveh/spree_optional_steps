module Spree
  module Admin
    ShipmentsController.class_eval do
      private

        def build_shipment
          @shipment = @order.shipments.build
          if @order.delivery_required?
            @shipment.address ||= @order.ship_address
            @shipment.address ||= Address.new(:country_id => Spree::Config[:default_country_id])
          else
            @shipment.address = nil
          end
          @shipment.shipping_method ||= @order.shipping_method
          @shipment.attributes = params[:shipment]
        end
    end
  end
end
