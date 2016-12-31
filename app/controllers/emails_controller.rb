class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  def index
    partner = Partner.find(params[:partner]) || current_user.partners.first.id
    @emails = Email.where(user_id: current_user, partner_id: partner.id)
    if @emails.empty?
      email_service = EmailRetrievalService.new(current_user)
      email_service.retrieve_emails(partner)
      @emails = Email.where(user_id: current_user, partner_id: partner.id)
      analyze_sentiment(@emails)
    end
    render 'index'
  end

  def show
  end

  def new
    @email = Email.new
  end

  def edit
  end

  def create
    @email = Email.new(email_params)
    respond_to do |format|
      if @email.save
        analyze_sentiment
        format.html { redirect_to @email }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_email
      @email = Email.find(params[:id])
    end

    def email_params
      params.require(:email).permit(:name, :text, :user_id, :partner_id, :relationship_id)
    end

    def analyze_sentiment(emails)
      sentiment_service = SentimentAnalyzerService.new
      sentiment_service.get_sentiment(emails)
    end

end
