class PagesController < ApplicationController

  before_action :authenticate_user! 
  skip_before_action :authenticate_user!, :only => [:index, :products, :webhook]
  protect_from_forgery :except => :webhook

  def webhook
   head 200
  end

  def index
  end

  def products
	@books=Book.all
	@plans=Plan.all
  end

  def page0
	@books=BuyBook.where(user_id: current_user.id)
	@plans=BuyPlan.where(user_id: current_user.id)

        if current_user.stripe_id.present?
               @card=Stripe::Customer.retrieve(current_user.stripe_id)
        end
  end


  def page_good
        if current_user.good?
                file_path = "#{Rails.root}/protected/Good/" + params[:url]
                send_file(file_path, type: 'text/html', disposition: 'inline')
        else
                render plain: "you do not have access"
        end
  end

  def page_better
        if current_user.better?
                file_path = "#{Rails.root}/protected/Better/" + params[:url]
                send_file(file_path, type: 'text/html', disposition: 'inline')
        else
                render plain: "you do not have access"
        end
  end

  def page_best
        if current_user.best?
                file_path = "#{Rails.root}/protected/Best/" + params[:url]
                send_file(file_path, type: 'text/html', disposition: 'inline')
        else
                render plain: "you do not have access"
        end
  end

end
