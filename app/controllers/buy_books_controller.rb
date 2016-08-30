class BuyBooksController < ApplicationController
  before_action :set_buy_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # Buy new book
  #
  # If user already purchased book, redirect to control panel
  # else buy the book
  #
  def new
	@bought=BuyBook.where(user_id: current_user.id).where(book_id: params[:book_id])
	if @bought.present?
     		redirect_to pages_page0_path, :flash => { :notice => "you already have this book" }
	else
		@card=Card.where(user_id: current_user.id)
		@book=Book.find(params[:book_id])
	end
  end


  # Create new stripe transaction
  # 
  def create
    @book=Book.find(params[:book_id])
	if @book.present?
    		@amount = (100* @book.price).to_i
    		@desc=@book.title
	else
     		redirect_to new_buy_book_path, :flash => { :error => "book not found" }
	end

   if !params[:customer_id].present?
    	customer = Stripe::Customer.create(
     	:email => params[:stripeEmail],
     	:source  => params[:stripeToken]
   	)

   	@card=Card.new(:stripe_token => customer.id, :user_id => current_user.id, :last4 => customer.sources.first.last4 )
   	@card.save
	customer_id=customer.id
   else
	customer_id=params[:customer_id]
   end

   charge = Stripe::Charge.create(
     :customer    => customer_id,
     :amount      => @amount,
     :description => @desc,
     :currency    => 'usd'
   )

   @book=BuyBook.new(:book_id => params[:book_id], :user_id => current_user.id)
   @book.save


   redirect_to pages_page0_path, :flash => { :notice => "purchase completed" }

   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_buy_book_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_book
      @buy_book = BuyBook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_book_params
      params.fetch(:buy_book, {})
    end
end

