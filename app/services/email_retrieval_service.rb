class EmailRetrievalService
  def initialize(user)
    @user = user
    @gmail = Gmail.connect!(user.email, user.password)
  end

  def retrieve_emails(partner, relationship)
    @emails = @gmail.inbox.emails(from: partner.email)
    save_emails(partner, relationship)
    @email_count = @emails.count
  end

  def save_emails(partner, relationship)
    @emails.each do |email|
      Email.create(subject: email.subject, user_id: @user.id, partner_id: partner.id, relationship_id: relationship.id, text: clean_email_text(email), sent_at: email.date)
    end
  end

  def clean_email_text(email)
    email.body.decoded
  end

end
