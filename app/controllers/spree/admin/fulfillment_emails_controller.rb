# frozen_string_literal: true

module Spree
  module Admin
    class FulfillmentEmailsController < ResourceController
      skip_before_action :load_resource, only: :index

      def index
        @search = ::SolidusFulfillmentEmails::Email.accessible_by(current_ability).ransack(params[:q])
        @emails = @search.result(distinct: true).
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:orders_per_page])
      end

      def new
      end

      private 

      def model_class
        ::SolidusFulfillmentEmails::Email
      end

      def permitted_resource_params
        params.require(:solidus_fulfillment_emails_email).permit(:subject, :bcc_to, :send_to_admin, :send_to_customer, :content)
      end

      def location_after_save
        admin_fulfillment_emails_path
      end

      def edit_object_url(object)
        edit_admin_fulfillment_email_path(object)
      end

      def object_url(object)
        admin_fulfillment_email_path(object)
      end

    end
  end
end
