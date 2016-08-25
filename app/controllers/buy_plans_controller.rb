class BuyPlansController < ApplicationController
  before_action :set_buy_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /buy_plans/new
  def new
        @bought=BuyPlan.where(user_id: current_user.id).where(plan_id: params[:plan_id])

        if @bought.present?
                redirect_to pages_page0_path
        else
		@plan=Plan.find(params[:plan_id])
        end
  end

  # POST /buy_plans
  # POST /buy_plans.json
  def create
    # Amount in cents
    @plan=Plan.find(params[:plan_id])

    customer = Stripe::Customer.create(
     :email => params[:stripeEmail],
     :source  => params[:stripeToken]
   )

   subscription = customer.subscriptions.create(:plan => @plan.stripe_id )

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
