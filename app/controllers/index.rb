get '/' do
  erb :index
  # This page has create account in erb and login
  # let's do two separate forms
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
    erb :secret
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
