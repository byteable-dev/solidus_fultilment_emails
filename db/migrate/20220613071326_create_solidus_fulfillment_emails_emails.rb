class CreateSolidusFulfillmentEmailsEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :solidus_fulfillment_emails_emails do |t|
      t.string :subject
      t.string :content
      t.boolean :send_to_customer
      t.boolean :send_to_admin
      t.string :bcc_to

      t.timestamps
    end
  end
end
