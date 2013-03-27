helpers do

def current_user
  @current_user ||= TwitterUser.find(session[:twitter_user_id])
end

end
