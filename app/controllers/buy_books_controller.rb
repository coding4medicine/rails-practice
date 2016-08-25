class BuyBooksController < ApplicationController
  before_action :set_buy_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /buy_books/new
  def new
	# if current user already bought the book, take to control panel
	# else continue with buy
	@book=Book.find(params[:book_id])
  end

  # POST /buy_books
  # POST /buy_books.json
  def create
    # Amount in cents
    @book=Book.find(params[:book_id])
	if @book.blank?
		@amount=1000
		@desc="AAA"
	else
    		@amount = (100* @book.price).to_i
    		@desc=@book.title
	end

    customer = Stripe::Customer.create(
     :email => params[:stripeEmail],
     :source  => params[:stripeToken]
   )

   charge = Stripe::Charge.create(
     :customer    => customer.id,
     :amount      => @amount,
     :description => @desc,
     :currency    => 'usd'
   )

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
