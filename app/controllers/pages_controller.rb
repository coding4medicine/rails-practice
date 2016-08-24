class PagesController < ApplicationController

  before_action :authenticate_user! 
  skip_before_action :authenticate_user!, :only => [:index, :book, :plan]

  def index
  end

  def book
	@books=Book.all
  end

  def plan
	@plans=Plan.all
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
