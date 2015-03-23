class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      #Sign in successful
      sign_in user
      redirect_back_or user
    else
      #Sing in Failed
      flash.now[:error] = 'Invalid Password or Email' 
      render 'new'
    end
    
  end
  
  def destroy
    sign_out
    redirect_to root_path 
  end
end
