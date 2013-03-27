get '/' do
  unless session[:twitter_user_id] == nil
    @current_user = TwitterUser.find(session[:twitter_user_id])
  end

  erb :index
end

post '/tweet/new' do
  @job_id = TwitterUser.find(session[:twitter_user_id]).tweet(params[:text])
  puts "%" * 100
  puts "@job_id is: #{@job_id}"
  puts "job_id class is #{@job_id.class}"
  puts "%" * 100
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
  
  puts params[:job_id].inspect
  puts params[:job_id].class
  puts "*"*500
  puts job_is_complete(params[:job_id])
  job_is_complete(params[:job_id]).to_s
end

