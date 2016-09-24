class SessionsController < ApplicationController
  def new
  end

  def create
  	member = Member.find_by(email: params[:session][:email].downcase)
  	if member && member.authenticate(params[:session][:password])
  		log_in member
  		redirect_to member
  	else
  		#show error message and redirect to the login page again
  		flash.now[:danger] = 'Invalid email/password combination'
  	    render 'new'
    end
  end

  def destroy
  	log_out
    redirect_to home_path
  end
end
