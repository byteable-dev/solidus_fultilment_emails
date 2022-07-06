# frozen_string_literal: true

module SolidusFulfillmentEmails
  ##
  # Filfillment Mailer
  #
  # The mailer class that can send mails
  class FulfillmentMailer < ::Spree::BaseMailer
    ##
    # Fulfill
    #
    # The actual fulfill email that is used to send to customers or admins etc
    def fulfill
      @order = params[:order]
      @email = params[:email]
      @product = params[:product]

      mail(to: params[:sent_to],
        bcc: @email.bcc_to,
        subject: @email.subject,
        from: from_address(@order.store))
    end
  end
end
