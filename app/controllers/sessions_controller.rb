class SessionsController < ApplicationController
    def new
    end
  
    def create
        user = User.find_by(username: params[:username])
      
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:role] = user.role
      
          # Redirect based on role
          if user.role == 'admin'
            redirect_to dashboard_path, notice: "Welcome, #{user.username}!"
          else
            redirect_to root_path, notice: "Welcome, #{user.username}!"
          end
        else
          flash.now[:alert] = 'Invalid username or password.'
          render :new
        end
      end
  
      def destroy
        session[:user_id] = nil
        session[:role] = nil
        reset_session   # clears everything for safety
        redirect_to login_path, notice: "You have been logged out."
      end
      
  end