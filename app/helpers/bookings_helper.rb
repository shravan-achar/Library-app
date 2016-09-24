module BookingsHelper
  def isAdmin
    if not session.key? :lib_user
      return false
    end

    return session[:lib_user][0]=="a"
  end

  def getUserId
    if not session.key? :lib_user
      return -1
    end

    user = session[:lib_user]
    return user[1,user.size]
  end

end
