class AddSentimentToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :sentiment, :string
    add_column :emails, :score, :float
  end
end
