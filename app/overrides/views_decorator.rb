Deface::Override.new(
  :virtual_path => "spree/admin/shipping_categories/_form",
  :name => "optional_steps_admin_shipping_categories_delivery_required",
  :insert_bottom => "[data-hook='name']",
  :partial => "spree/admin/shipping_categories/delivery_required"
)

Deface::Override.new(
  :virtual_path => "spree/admin/shipments/_form",
  :name => "optional_steps_admin_shipments_address",
  :replace => "[data-hook='admin_shipment_form_address']",
  :partial => "spree/admin/shipments/address"
)
