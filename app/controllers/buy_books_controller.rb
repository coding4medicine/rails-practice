class BuyBooksController < ApplicationController
  before_action :set_buy_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /buy_books/new
  def new
	# If book is already purchased by user, redirect to control panel
	# else buy the book
	@bought=BuyBook.where(user_id: current_user.id).where(book_id: params[:book_id])
	if @bought.present?
     		redirect_to pages_page0_path
	else
		@book=Book.find(params[:book_id])
	end
  end

  # POST /buy_books
  # POST /buy_books.json
  def create
    # Amount in cents
    @book=Book.find(params[:book_id])
	if @book.present?
    		@amount = (100* @book.price).to_i
    		@desc=@book.title
	else
     		flash[:error] = "book not found"
     		redirect_to new_buy_book_path
	end

    customer = Stripe::Customer.create(
     :email => params[:stripeEmail],
     :source  => params[:stripeToken]
   )
	@card=Card.new(:stripe_token => params[:stripeToken], :user_id => current_user.id)
	@card.save

   charge = Stripe::Charge.create(
     :customer    => customer.id,
     :amount      => @amount,
     :description => @desc,
     :currency    => 'usd'
   )

	@book=BuyBook.new(:book_id => params[:book_id], :user_id => current_user.id)
	@book.save

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
