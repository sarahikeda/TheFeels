class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  def current_user
    @user || User.find(session[:user_id]) if session[:user_id]
  end

  def connect_gmail
    user = @user || current_user
    @gmail = Gmail.connect!(user.email, user.password)
  end

  def retrieve_emails
    @emails = @gmail.inbox.emails(from: @partner.email)
    save_emails
    @email_count = @emails.count
  end

  def save_emails
    @emails.each do |email|
      Email.create(subject: email.subject, user_id: @user.id, partner_id: @partner.id, relationship_id: @relationship.id, text: clean_email_text(email), sent_at: email.date)
    end
  end

  def clean_email_text(email)
    email.body.decoded
  end
end
