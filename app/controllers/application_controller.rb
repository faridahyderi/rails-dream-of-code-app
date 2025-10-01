class ApplicationController < ActionController::Base
 
  allow_browser versions: :modern

  def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_student
    if session[:role] != 'student'
      flash[:alert] = 'Only students can perform that action'
      redirect_to root_path
    end
  end

  def require_mentor
    if session[:role] != 'mentor'
      flash[:alert] = 'Only mentors can perform that action'
      redirect_to root_path
    end
  end
end
