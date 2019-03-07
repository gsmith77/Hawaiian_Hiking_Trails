class UserController < Sinatra::Base

  #create CRUD and RESTful routes


  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/registrations/signup'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user != nil && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect to '/account'
    end
    erb :error
  end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    if @user
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
