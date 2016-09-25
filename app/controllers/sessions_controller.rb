class SessionsController < ApplicationController
  def new
  end

  def create

    if params[:session][:Admin].to_i==1
      admin = Admin.find_by(email: params[:session][:email].downcase)
      if admin && admin.authenticate(params[:session][:password])
        admin_log_in admin
        redirect_to admins_options_url, :notice=>"Admin Successfully logged in"
      else
        #show error message and redirect to the login page again
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      member = Member.find_by(email: params[:session][:email].downcase)
      if member && member.authenticate(params[:session][:password])
        log_in member
        redirect_to bookings_makebooking_url, :notice=>"Member Successfully logged in"
      else
        #show error message and redirect to the login page again
        flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
      end
    end
  end

  def destroy
  	log_out
    redirect_to home_path
  end
end
