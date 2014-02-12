get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do

  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token

  @user = User.find_or_create_by(username: @access_token.params[:screen_name])
  @user.update(oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  @user.save
  session[:username] = @user.username

  erb :index
end

post '/ajax_tweet' do
  user = User.find_by_username(session[:username])

  job_id = user.tweet(params[:status])

  content_type :json
  {job_id: job_id}.to_json
end

get '/status/:job_id' do
  puts 'We got here'
  result = job_is_complete(params[:job_id])
  erb :index if result

end
