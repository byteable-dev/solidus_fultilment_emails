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
end
