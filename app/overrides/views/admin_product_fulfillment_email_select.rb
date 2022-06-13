# frozen_string_literal: true

Deface::Override.new(
  virtual_path: "spree/admin/products/_form",
  name: "solidus_fulfillment_emails_product_fulfillment_email_select",
  insert_after: "[data-hook='admin_product_form_tax_category']",
  partial: "spree/admin/products/fulfillment_email_select"
)
