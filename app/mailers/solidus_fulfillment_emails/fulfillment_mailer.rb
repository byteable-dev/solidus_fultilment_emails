# frozen_string_literal: true

module SolidusFulfillmentEmails
  class FulfillmentMailer < ::Spree::BaseMailer
    def fulfill
      @order = params[:order]
      @email = params[:email]
      @product = params[:product]

      mail(to: params[:sent_to], 
           bcc: @email.bcc_to, 
           subject: @email.subject)
    end
  end
end
