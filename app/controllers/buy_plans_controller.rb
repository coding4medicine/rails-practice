class BuyPlansController < ApplicationController
  before_action :set_buy_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # subscribe to new plan
  #
  def new
	
#Server-monthly                  Server-monthly                  N
#Server-yearly                   Server-monthly                  D
#Book-monthly                    Server-monthly                  U
#Book-yearly                     Server-monthly                  D
#Server-monthly                  Server-yearly                   U
#Server-yearly                   Server-yearly                   N
#Book-monthly                    Server-yearly                   U
#Book-yearly                     Server-yearly                   U
#Server-monthly                  Book-monthly                    D
#Server-yearly                   Book-monthly                    D
#Book-monthly                    Book-monthly                    N
#Book-yearly                     Book-monthly                    D
#Server-monthly                  Book-yearly                     U
#Server-yearly                   Book-yearly                     D
#Book-monthly                    Book-yearly                     U
#Book-yearly                     Book-yearly                     N


        #@bought=BuyPlan.where(user_id: current_user.id).where(status: 1).first
        @bought=BuyPlan.find_by user_id: current_user.id

	change="Z"

	case @bought.plan_id
	when 1
		case params[:plan_id]
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
		case params[:plan_id]
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
		case params[:plan_id]
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
		case params[:plan_id]
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

	case change
	when "N"
                redirect_to pages_page0_path
	when "D"
		redirect_to pages_page0_path, :flash => { :notice => "We will make change after current period." }
        else
		@card=Card.where(user_id: current_user.id)
		@plan=Plan.find(params[:plan_id])
        end
  end

  # create new stripe transaction
  #
  def create
    @plan=Plan.find(params[:plan_id])
        if !@plan.present?
                redirect_to new_buy_plan_path, :flash => { :error => "plan not found" }
        end

   if !params[:customer_id].present?

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      @card=Card.new(:stripe_token => params[:stripeToken], :user_id => current_user.id)
      @card.save
   else
     customer=Stripe::Customer.find(params[:customer_id])
   end 

   subscription = customer.subscriptions.create(:plan => @plan.stripe_id )

   @plan=BuyPlan.new(:plan_id => params[:plan_id], :user_id => current_user.id, :status=>1)
   @plan.save

   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_buy_plan_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buy_plan
      @buy_plan = BuyPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buy_plan_params
      params.fetch(:buy_plan, {})
    end
end
