class AddFullfillmentEmailIdToSpreeProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_products, :fulfillment_email_id, :integer
  end
end
