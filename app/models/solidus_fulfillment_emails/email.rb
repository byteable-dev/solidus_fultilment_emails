##
# Fulfilment Email model
#
# Holds information about a fulfillment email like subject,
# content etc.
class SolidusFulfillmentEmails::Email < ApplicationRecord
  self.table_name = 'solidus_fulfillment_emails_emails'

  # Validations
  validates :subject, presence: true
  validates :content, presence: true
  validates :bcc_to, format: { with: Devise.email_regexp }, if: lambda { |m| m.bcc_to.present? }

  ##
  # Handles replacement of variables in the email
  def content_replaced(order)
    address = order.billing_address || order.shipping_address
    replacements = {
      order_number: order.number,
      order_total: order.total,
      name: address&.name || order.email,
    }

    final_content = content
    replacements.each do |k, v|
      final_content = final_content.gsub("{{#{k}}}", v.to_s)
    end
    final_content
  end
end
