# frozen_string_literal: true

module Spree
  module Admin
    ##
    # Fulfillment Email Controller
    #
    # Handles the CRUD for admins for create fulfill emails.
    class FulfillmentEmailsController < ResourceController
      # We skip auto loading of resource in index to handle this our self because
      # we want to handle some sorting etc.
      skip_before_action :load_resource, only: :index

      ##
      # Index
      # 
      # Override index to handle sorting etc.
      def index
        @search = ::SolidusFulfillmentEmails::Email.accessible_by(current_ability).ransack(params[:q])
        @emails = @search.result(distinct: true).
          page(params[:page]).
          per(params[:per_page] || Spree::Config[:orders_per_page])
      end

      private 

      ##
      # Model Class
      #
      # The class to use as resource
      def model_class
        ::SolidusFulfillmentEmails::Email
      end

      ##
      # Permited Params
      #
      # The parameters needed to create new email templates
      def permitted_resource_params
        params.require(:solidus_fulfillment_emails_email).permit(:subject, :bcc_to, :send_to_admin, :send_to_customer, :content)
      end

      ##
      # Location afer save
      #
      # The location to redirect user to after an email is saved
      def location_after_save
        admin_fulfillment_emails_path
      end

      ##
      # Edit object url
      #
      # Used in views to determine the edit url of an email
      def edit_object_url(object)
        edit_admin_fulfillment_email_path(object)
      end

      ##
      # Object url
      #
      # Used in views to determine the url of an email
      def object_url(object)
        admin_fulfillment_email_path(object)
      end

    end
  end
end
