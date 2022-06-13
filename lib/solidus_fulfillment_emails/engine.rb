# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusFulfillmentEmails
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_fulfillment_emails'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    initializer 'solidus_fulfillment_emails.configure_backend' do
      next unless ::Spree::Backend::Config.respond_to?(:menu_items)

      ::Spree::PermittedAttributes.product_attributes << [:fulfillment_email_id]

      ::Spree::Backend::Config.configure do |config|
        config.menu_items << config.class::MenuItem.new(
          [:fulfillment_emails],
          'envelope',
          url: :admin_fulfillment_emails_path,
          condition: ->{ can?(:admin, ::SolidusFulfillmentEmails::Email) },
          match_path: '/fulfillment_emails'
        )
      end
    end

  end
end
