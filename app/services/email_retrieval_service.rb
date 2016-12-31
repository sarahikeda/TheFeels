class EmailRetrievalService
  def initialize(user)
    @user = user
    @gmail = Gmail.connect(:xoauth2, user.email, user.oauth_token)
  end

  def retrieve_emails(partner)
    emails = @gmail.inbox.emails(from: partner.email).last(10)
    save_emails(partner, emails)
    emails
  end

  def save_emails(partner, emails)
    emails.each do |email|
      new_email = Email.new(user_id: @user.id, partner_id: partner.id)
      new_email.update(subject: email.subject, text: clean_email_text(email), sent_at: email.date)
    end
  end

  def clean_email_text(email)
    text = ActionView::Base.full_sanitizer.sanitize(email.body.decoded)
    only_text = remove_image(text)
    shortened_text = shorten_text(only_text)
    cleaned_headers = remove_headings(shortened_text)
    cleaned_spaces = remove_spaces(cleaned_headers)
    cleaned_text = remove_numbers(cleaned_spaces)
    return RbLibText.tokens(cleaned_text).join(" ")
  end

  def remove_image(text)
    text =~ /Content-Type: image\/jpeg/ ? '' : text
  end

  def shorten_text(text)
    text.truncate(200000)
  end

  def remove_headings(text)
    text.gsub(/.*Content-Transfer-Encoding/,'').gsub(/.*Content-Type.*[uUtTfF]-8/,'').gsub(/ application\/pdf.*/,'').gsub(/Content-Disposition.*/,'')
  end

  def remove_spaces(text)
    text.gsub(/\\n/,'')
  end

  def remove_numbers(text)
    text.gsub(/--.?\d*/,'')
  end

end
