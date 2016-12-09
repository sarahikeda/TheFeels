class EmailRetrievalService
  def initialize(user)
    @user = user
    @gmail = Gmail.connect(:xoauth2, user.email, user.oauth_token)
  end

  def retrieve_emails(partner, relationship)
    @emails = @gmail.inbox.emails(from: partner.email).first(10)
    save_emails(partner, relationship)
    @email_count = @emails.count
  end

  def save_emails(partner, relationship)
    @emails.each do |email|
      new_email = Email.new(user_id: @user.id, partner_id: partner.id, relationship_id: relationship.id)
      new_email.update(subject: email.subject, text: clean_email_text(email), sent_at: email.date)
    end
  end

  def clean_email_text(email)
    text = ActionView::Base.full_sanitizer.sanitize(email.body.decoded)
    text.gsub(/^.+text\/plain; charset=UTF-8/,'').gsub(/\\n/,'')
    text = RbLibText.tokens(text).join(" ")
  end

end
