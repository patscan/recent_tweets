# kill all instancers of shotgun
# lsof -ti :9393 | xargs kill -9

get '/' do
end

get '/:username' do
  @username = params[:username]
  erb :loading
end


get '/fetch/:username' do
  @user = TwitterUser.includes(:recent_tweets).where(username: params[:username]).first_or_create
  if @user.cache_stale?
    @new_tweets = @user.fetch_tweets!
  else
    @new_tweets = @user.recent_tweets
  end
  erb :_tweet_table, :layout => false
end

