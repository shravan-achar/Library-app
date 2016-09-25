module SessionsHelper
	# Logs in the given member.
  def log_in(member)
    session[:lib_user] = "m"+member.id.to_s
  end

  def admin_log_in(admin)
    session[:lib_user] = "a"+admin.id.to_s
  end

  # Returns the current logged-in member (if any).
  def current_member
    mem_id =
    @current_member ||= Member.find_by(id: session[:libe])
  end

  def logged_in?
    session.key?(:lib_user)
    # !current_member.nil?
  end

  def admin_logged_in?
    if (session.key? :lib_user)
      if (session[:lib_user][0] == 'a')
        return true
      else
        return false
      end
    else
      return false
    end

  end

  def log_out
    session.delete(:lib_user)
    # @current_member = nil
  end
end
