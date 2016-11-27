class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :name
      t.string :subject
      t.string :text
      t.integer :user_id
      t.integer :partner_id
      t.integer :relationship_id
      t.datetime :sent_at
      t.timestamps null: false
    end
  end
end
