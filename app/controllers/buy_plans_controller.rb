class BuyPlansController < ApplicationController

  before_action :authenticate_user!

  # subscribe to new plan
  #
  # Server-monthly                  Server-monthly                  N
  # Server-yearly                   Server-monthly                  D
  # Book-monthly                    Server-monthly                  U
  # Book-yearly                     Server-monthly                  D
  # Server-monthly                  Server-yearly                   U
  # Server-yearly                   Server-yearly                   N
  # Book-monthly                    Server-yearly                   U
  # Book-yearly                     Server-yearly                   U
  # Server-monthly                  Book-monthly                    D
  # Server-yearly                   Book-monthly                    D
  # Book-monthly                    Book-monthly                    N
  # Book-yearly                     Book-monthly                    D
  # Server-monthly                  Book-yearly                     U
  # Server-yearly                   Book-yearly                     D
  # Book-monthly                    Book-yearly                     U
  # Book-yearly                     Book-yearly                     N
  #

  def new
	if params[:id].present?
        	#@bought=BuyPlan.where(user_id: current_user.id).where(status: 1).first
        	@bought=BuyPlan.find_by user_id: current_user.id
		change="Z"

		if @bought.present?
			case @bought.plan_id
			when 1
				case params[:id]
				when 1
					change="N"
				when 2
					change="U"
				when 3
					change="U"
				when 4
					change="U"
				end
			when 2
				case params[:id]
				when 1
					change="D"
				when 2
					change="N"
				when 3
					change="U"
				when 4
					change="U"
				end
			when 3
				case params[:id]
				when 1
					change="D"
				when 2
					change="D"
				when 3
					change="N"
				when 4
					change="U"
				end
			when 4
				case params[:id]
				when 1
					change="D"
				when 2
					change="D"
				when 3
					change="D"
				when 4
					change="N"
				end
			end
		end

		case change
		when "N"
                	redirect_to pages_page0_path, :flash => { :notice => "You are subscribed"}
			return
		when "D"
			redirect_to pages_page0_path, :flash => { :notice => "We will make change after current period." }
			return
        	else
			if current_user.stripe_id.present?
				@card=Stripe::Customer.retrieve(current_user.stripe_id)
			end
			@plan=Plan.find(params[:id])
        	end
	else
		redirect_to pages_products_path, :flash => { :notice => "plan not found" }
	end
	rescue ActiveRecord::RecordNotFound => e
		redirect_to pages_products_path, :flash => { :notice => "plan not found" }
  end


  # Create - new customer_id or card
  #
  def create
	@plan=Plan.find(params[:plan_id])
	if !@plan.present?
		redirect_to new_buy_plan_path, :flash => { :error => "plan not found" }
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

	subscription = customer.subscriptions.create(:plan => @plan.stripe_id )

	@plan=BuyPlan.new(:plan_id => params[:plan_id], :user_id => current_user.id, :status=>1)
	@plan.save

	redirect_to pages_page0_path, :flash => { :notice => "purchase completed" }

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_buy_plan_path(:id => params[:plan_id])
  end


  # Edit - charge existing customer
  #
  def edit
	if !current_user.valid_password?(params[:password])
		redirect_to pages_products_path, :flash => { :notice => "password incorrect" }
		return
	else
		@plan=Plan.find(params[:plan_id])
		if !@plan.present?
			redirect_to new_buy_plan_path, :flash => { :error => "plan not found" }
			return
		end

     		customer=Stripe::Customer.retrieve(current_user.stripe_id)
		subscription = customer.subscriptions.create(:plan => @plan.stripe_id )

		@plan=BuyPlan.new(:plan_id => params[:plan_id], :user_id => current_user.id, :status=>1)
		@plan.save
		redirect_to pages_page0_path, :flash => { :notice => "purchase completed" }
	end

	rescue Stripe::CardError => e
		flash[:error] = e.message
		redirect_to new_buy_plan_path
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_plan_params
      params.fetch(:buy_plan, {})
    end
end

