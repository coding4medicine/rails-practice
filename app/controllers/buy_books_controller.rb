class BuyBooksController < ApplicationController

  before_action :authenticate_user!

  # Buy new book
  #
  # If user already purchased book, redirect to control panel
  # else buy the book
  #
  def new
	if params[:id].present?
		@bought=BuyBook.where(user_id: current_user.id).where(book_id: params[:id])
		if @bought.present?
			# user already bought book
     			redirect_to pages_page0_path, :flash => { :notice => "you already have this book" }
			return
		else
			if current_user.stripe_id.present?
				@card=Stripe::Customer.retrieve(current_user.stripe_id)
			end
			@book=Book.find(params[:id])
		end
	else
     			redirect_to pages_products_path, :flash => { :notice => "book not found" }
	end	
	rescue ActiveRecord::RecordNotFound => e
		redirect_to pages_products_path, :flash => { :notice => "book not found" }
  end


  # Create - new stripe customer_id or card
  # 
  # This function works, if the customer chooses to add new card
  # (i) existing customer_id --> add card, or (ii) create new user and card
  #

  def create
	@book=Book.find(params[:book_id])
	if @book.present?
		@amount = (100* @book.price).to_i
		@desc=@book.title
	else
		redirect_to pages_products_path, :flash => { :notice => "book not found" }
		return
	end

	if current_user.stripe_id.present?
		customer_id=current_user.stripe_id
		customer = Stripe::Customer.retrieve(customer_id)
		customer.sources.create(:source  => params[:stripeToken])
	else
		customer = Stripe::Customer.create(
     			:email => params[:stripeEmail],
     			:source  => params[:stripeToken]
   		)

		customer_id=customer.id
		current_user.stripe_id=customer_id
		current_user.save(validate: false)
	end

	charge = Stripe::Charge.create(
		:customer    => customer_id,
		:amount      => @amount,
		:description => @desc,
		:currency    => 'usd'
	)

	@book=BuyBook.new(:book_id => params[:book_id], :user_id => current_user.id, :price => @amount )
	@book.save

	redirect_to pages_page0_path, :flash => { :notice => "purchase completed" }

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_buy_book_path(:id => params[:book_id])
  end



  # Edit -charge existing stripe customer_id
  # 
  # check for password, check card and charge
  #
  def edit
	if !current_user.valid_password?(params[:password])
		redirect_to pages_products_path, :flash => { :notice => "password incorrect" }
		return
	else
		@book=Book.find(params[:book_id])
		if @book.present?
			@amount = (100* @book.price).to_i
			@desc=@book.title
		else
			redirect_to pages_products_path, :flash => { :error => "book not found" }
			return
		end

		customer_id=current_user.stripe_id

		charge = Stripe::Charge.create(
			:customer    => customer_id,
		:card        => params[:card_id],
		:amount      => @amount,
		:description => @desc,
		:currency    => 'usd'
		)

		@book=BuyBook.new(:book_id => params[:book_id], :user_id => current_user.id, :price => @amount )
		@book.save

		redirect_to pages_page0_path, :flash => { :notice => "purchase completed" }
	end

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_buy_book_path(:id => params[:book_id])
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_book_params
      params.fetch(:buy_book, {})
    end

end


