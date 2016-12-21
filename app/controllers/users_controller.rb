class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @partner = Partner.new
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @partner = Partner.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        @partner = Partner.find(params[:partner_name][:partner_id])
        email = Email.where(user_id: current_user, partner_id: @partner.id)
        if email.empty?
          email_service = EmailRetrievalService.new(current_user)
          if params[:partner_name]
            find_partner
          else
            create_partner
          end
          create_relationship
          email_service = email_service.retrieve_emails(@partner, @relationship)
        end
        format.html { redirect_to emails_path, partner: @partner.id }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :password)
    end

    def find_partner
      @partner = Partner.find(params[:partner_name][:partner_id])
    end

    def create_partner
      @partner = Partner.create(name: params[:partner][:name], email: params[:partner][:email])
    end

    def create_relationship
      @relationship = Relationship.create(user_id: @user.id, partner_id: @partner.id)
    end

end
