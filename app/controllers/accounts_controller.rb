class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = current_user.accounts
  end

  def show
      # already setup with the befoer_action
  end

  def new
    @account = current_user.accounts.new
    # make a new account for the current user
  end

  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      flash[:success] = "Account created"
      redirect_to accounts_path
    else
      # binding.pry
      flash[:error] = "Error: #{@account.errors.messages[:balance][0]}"
      # the message you are getting the array from a hash (think Ruby)
      render :new
    end
  end

  def edit
    # take care of with before action
  end

  def update
    if @account.update(account_params)
      redirect_to accounts_path
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private
  def account_params
    params.require(:account).permit(:name, :balance)
  end

    def set_account
      # don't user Account model or you may be able to view or manipulation other people account. 
      # ex: Account.find(params[:id])
      @account = current_user.accounts.find(params[:id])
    end

end
