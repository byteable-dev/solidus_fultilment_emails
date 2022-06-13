# frozen_string_literal: true

module SolidusFulfillmentEmails
  module FulfillEmailSubscriber
    include Spree::Event::Subscriber

    event_action :order_finalized

    def order_finalized(event)
      order = event.payload[:order]

      fulfillment_products = []

      order.products.each do |product|
        if product.respond_to?(:parts)
          product.parts.each do |variant|
            next if variant.product.fulfillment_email_id.blank?
            fulfillment_products << variant.product
          end
        end
        
        next if product.fulfillment_email_id.blank?
        fulfillment_products << product
      end


      fulfillment_products.each do |product|
        email = ::SolidusFulfillmentEmails::Email.find_by_id(product.fulfillment_email_id)
        next if email.nil?

        if email.send_to_customer
          deliver!(order.email, order, email, product)
        end

        if email.send_to_admin
          admins = ::Spree::User.joins(:role_users).where(role_users: { role_id: 1 })
          admins.each do |admin|
            deliver!(admin.email, order, email, product)
          end
        end
      end

    end

    private

    def deliver!(sent_to, order, email, product)
      ::SolidusFulfillmentEmails::FulfillmentMailer.with(sent_to: sent_to,
                                                         order: order,
                                                         email: email,
                                                         product: product).fulfill.deliver_later
    end

  end
end

