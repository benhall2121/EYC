class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to root_path
    end
  end
  
  def random_alphanumeric(size)
    # Get current time in seconds
    now_time = Time.now.usec.to_s

    if !current_user.nil?
      # Start the random string with the user_id
      random_string = current_user.id.to_s;
    else
      random_string = '21';
    end
    # Need to removethe length of the current user id and current time in seconds from The size of the randomly generated string the user wants 
    size -= random_string.length + now_time.length
    # Add the randomly generated string to the random_string variable
    random_string += (1..size).collect { (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }.join
    # Add the current time in seconds to the random_string variable
    random_string += now_time
  end

end
