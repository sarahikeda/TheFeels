class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :name
      t.integer :user_id
      t.integer :partner_id
      t.datetime :start_date
      t.timestamps null: false
    end
  end
end
