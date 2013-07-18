get '/' do
  @urls = Url.nil_urls
  erb :index
end

post '/user' do
  @user = User.authenticate(params[:user][:email], params[:user][:password])
  if @user
    session[:id] = @user.id
    redirect to ("/secret")  
  else
    @error = "password/email combination wrong/nonexistant"
    erb :index
  end
end

post '/create/user' do
  @user = User.new(:email => params[:user][:email],
                   :password => params[:user][:password])
  @user.save
  redirect ("/")
end

get '/secret' do
  if session[:id]
    @urls = Url.where("user_id = #{session[:id]}")
    erb :index
  else
    @error = "you must be logged in to view the secret page"
    erb :index
  end
end
 
post '/secret' do
  session[:id] = nil
  redirect ("/")
end
 #want to try the use you created in console?

 post '/urls' do
  @url = Url.new(params[:url])
  @url.short_url = Url.shorten
  @url.user_id = session[:id]|| nil
  @url.save
  redirect to ("/")
end

# e.g., /q6bda
get '/:short_url' do
  @short_url = params[:short_url]
  @url = Url.find_by_short_url(@short_url)
  @url.clicks += 1
  @url.save
  redirect to ("#{@url.long_url}")
end
