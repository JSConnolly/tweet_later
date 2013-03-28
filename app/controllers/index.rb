get '/' do
  unless session[:twitter_user_id] == nil
    @current_user = TwitterUser.find(session[:twitter_user_id])
  end

  erb :index
end

post '/tweet/new' do
  puts "%" * 100
  puts params
  puts "%" * 100
  unless params[:time].empty?
    @job_id = TwitterUser.find(session[:twitter_user_id]).tweet_in(params[:time], params[:text])
  else
    @job_id = TwitterUser.find(session[:twitter_user_id]).tweet(params[:text])
  end

  @job_id.to_s
end

get '/login/twitter' do
  redirect request_token.authorize_url
end

get '/auth' do
  get_access_token
  client
  redirect '/'
end

get '/status/:job_id' do
  status = job_is_complete(params[:job_id])
  tweet = current_user.tweets.last
  tweet.successful = status
  tweet.save!
  status.to_s
end

