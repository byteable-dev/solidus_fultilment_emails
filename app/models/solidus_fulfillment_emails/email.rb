class SolidusFulfillmentEmails::Email < ApplicationRecord
  self.table_name = 'solidus_fulfillment_emails_emails'

  validates :subject, presence: true
  validates :content, presence: true
  validates :bcc_to, format: { with: Devise.email_regexp }, if: lambda { |m| m.bcc_to.present? }
end
